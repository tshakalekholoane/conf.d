package main

import (
	"io"
	"log"
	"os"

	"github.com/yuin/goldmark"
	"github.com/yuin/goldmark/extension"
	"github.com/yuin/goldmark/renderer/html"
)

func do(f *os.File) {
	md := goldmark.New(
		goldmark.WithExtensions(extension.GFM),
		goldmark.WithRendererOptions(html.WithUnsafe()),
	)
	data, err := io.ReadAll(f)
	if err != nil {
		log.Fatalln(err)
	}
	if err = md.Convert(data, os.Stdout); err != nil {
		log.Fatalln(err)
	}
}

func main() {
	log.SetFlags(0)
	log.SetPrefix("markdown_to_html: ")
	args := os.Args[1:]
	if len(args) == 0 {
		do(os.Stdin)
	} else {
		for _, arg := range args {
			f, err := os.Open(arg)
			if err != nil {
				log.Fatalln(err)
			}
			do(f)
			f.Close()
		}
	}
}
