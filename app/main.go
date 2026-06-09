package main

import (
"fmt"
"log"
"net/http"
"os"
)

func main() {
http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
fmt.Fprintf(w, "Hello from GitOps! version=%s\n", version())
})

http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
w.WriteHeader(http.StatusOK)
fmt.Fprintln(w, "ok")
})

log.Println("listening on :8080")
log.Fatal(http.ListenAndServe(":8080", nil))
}

func version() string {
if v := os.Getenv("APP_VERSION"); v != "" {
return v
}
return "dev"
}
