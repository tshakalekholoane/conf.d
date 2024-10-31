package main

import (
	"errors"
	"flag"
	"fmt"
	"io/fs"
	"log"
	"os"
	"path/filepath"
)

var home = func() string {
	dir, err := os.UserHomeDir()
	if err != nil {
		panic(err)
	}
	return dir
}()

func main() {
	dir := flag.String("dir", filepath.Join(home, "x", "notes"), "notes directory")
	html := flag.Bool("html", false, "open note in browser")
	list := flag.Bool("list", false, "list notes")
	flag.Parse()

	log.SetFlags(0)
	log.SetPrefix("note: ")

	if *list {
		if err := os.Mkdir(*dir, 0o750); err != nil && !errors.Is(err, fs.ErrExist) {
			log.Fatal(err)
		}
		notes, err := filepath.Glob(filepath.Join(*dir, "[^.]*"))
		if err != nil {
			log.Fatalln(err)
		}
		for _, note := range notes {
			entries, err := os.ReadDir(note)
			if err != nil {
				log.Fatalln(err)
			}
			fmt.Print(filepath.Base(note) + ".{")
			for _, e := range entries {
				switch basename, name := filepath.Base(note), e.Name(); name {
				case basename + ".html":
					fmt.Print(filepath.Ext(name)[1:] + ",")
				case basename + ".txt":
					fmt.Print(filepath.Ext(name)[1:])
				}
			}
			fmt.Println("}")
		}
		return
	}

	// TODO: If flag.NArg == 0 default to starting the server.
	if flag.NArg() == 0 {
		flag.Usage()
		return
	}

	if *html {
		log.Fatalln("unimplemented")
	}

	arg := flag.Arg(0)
	contents, err := os.ReadFile(filepath.Join(*dir, arg, arg+".txt"))
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Println(string(contents))
}
