# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix", to: "https://ga.jspm.io/npm:trix@2.0.10/dist/trix.esm.js"
pin "@rails/actiontext", to: "actiontext.js", preload: true
pin "swiper", to: "https://ga.jspm.io/npm:swiper@8.4.4/swiper.esm.js"
pin "dom7", to: "https://ga.jspm.io/npm:dom7@4.0.4/dom7.esm.js"
pin "ssr-window", to: "https://ga.jspm.io/npm:ssr-window@4.0.2/ssr-window.esm.js"
pin "hotkeys-js", to: "https://ga.jspm.io/npm:hotkeys-js@3.10.0/dist/hotkeys.esm.js"
pin "stimulus-use", to: "https://ga.jspm.io/npm:stimulus-use@0.50.0/dist/index.js"
pin "stimulus-content-loader", to: "https://ga.jspm.io/npm:stimulus-content-loader@4.0.1/dist/stimulus-content-loader.es.js"
