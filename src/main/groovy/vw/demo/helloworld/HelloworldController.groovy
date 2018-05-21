package vw.demo.helloworld

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/hello")
class HelloworldController {

    @GetMapping("")
    String hello(String name) {
        return "Hello, ${name? name: 'world'}!"
    }

    @GetMapping("/kr")
    String helloKr(String name) {
        return "안녕하세요, ${name? name: 'world'}?"
    }

    @GetMapping("/jp")
    String helloJp(String name) {
        return "곤니찌와, ${name? name: 'world'}?"
    }
}
