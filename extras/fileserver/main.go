package main

import (
	"flag"
	"log"
	"net/http"
)

func main() {
	var (
		address   = flag.String("address", "127.0.0.1:8100", "port to serve on")
		directory = flag.String("dir", ".", "the directory of static file to host")
	)

	flag.Parse()

	var mux http.ServeMux

	mux.Handle("/", http.FileServer(http.Dir(*directory)))

	log.Printf("Serving %q on HTTP port: %q\n", *directory, *address)

	log.Fatal(http.ListenAndServe(*address, &mux))
}
