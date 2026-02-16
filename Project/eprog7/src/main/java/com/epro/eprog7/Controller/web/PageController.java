package com.epro.eprog7.Controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller

public class PageController {


// ------- Pagina Home (index.html) -------
    @GetMapping("/index")
    public String index() {
        return "index";
    }

// ------- Pagina Catalogo (catalogo.html) -------
    @GetMapping("/catalogo")
    public String catalogo() {
        return "catalogo";
    }

// ------- Pagina About (about.html) -------
    @GetMapping("/about")
    public String about() {
        return "about";
    }

}
