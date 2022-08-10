package main

import (
    "fmt"
    "net/http"
)

func about(w http.ResponseWriter, req *http.Request) {
    p := "./html/test.html"
    http.ServeFile(w, req, p)
}

func hello(w http.ResponseWriter, req *http.Request) {
    fmt.Fprintf(w, "hello\n")
}

func headers(w http.ResponseWriter, req *http.Request) {
    for name, headers := range req.Header {
	for _, h := range headers {
	    fmt.Fprintf(w, "%v: %v\n", name, h)
	}
    }
}

func main() {

   http.HandleFunc("/hello", hello)
   http.HandleFunc("/headers", headers)
   http.HandleFunc("/about",about)
   http.ListenAndServe(":8080", nil)
} 
