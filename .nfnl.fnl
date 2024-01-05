(local {: autoload} (require :nfnl.module))
(local overseer (autoload :overseer))

(fn get-ancestor-below-dot [path ?state]
  (assert (not (= path nil)) "expected non nil path")
  (let [state (or ?state {:depth 0})]

    (match [path state.depth]
      ; error
      [nil 0] [:error "path was nil"]
      ["." 0] [:error "path is dot"]
      ["" 0] [:error "path is empty"]

      ; continue
      _ (match (vim.fs.dirname path) 
          ; done case
          "." [:ok path]
          p (get-ancestor-below-dot p {:depth (+ state.depth 1)})
          ; _ (get-ancestor-below-dot path)
          )

      )))

(comment 
  (vim.fs.normalize (vim.fn.expand "%"))

  (vim.fs.dirname "abc/efg") ; "abc"
  (vim.fs.dirname "abc") ; "."
  (vim.fs.dirname ".") ; "."
  (vim.fs.dirname "") ; "."


  (do 


    (get-ancestor-below-dot "abc")
    (get-ancestor-below-dot "abc/def")
    (get-ancestor-below-dot ".")
    (get-ancestor-below-dot " ") ; have not handled this case yet
    )

  (string.gsub "a a" "^a" "")

  )

(fn remove-greatest-ancestor [path]
  (let [[_ ancestor-below-dot] (get-ancestor-below-dot path)
        rel-file-path (string.gsub path (.. "^" ancestor-below-dot "/") "")
        ]
    rel-file-path))

(comment 
  (remove-greatest-ancestor "abc/def/x.txt")
  )

(let [get-name-fn (fn [cmd file] 
                    (.. "mix " cmd " " file))]


  ; NOTE: should really change to look up the path for mix.exs
  (overseer.register_template 
    {:name "mix test this"
     :builder (fn [_params] 
                (let [file (vim.fn.expand "%")
                      [_ ancestor-below-dot] (get-ancestor-below-dot file)
                      rel-file-path (remove-greatest-ancestor file)
                      ]
                  {:cmd ["mix"]
                   :args ["test" rel-file-path]
                   :name (get-name-fn :test rel-file-path)
                   :env {}
                   ;; :strategy {1 :jobstart :use_terminal false}
                   :cwd "live_node"}))}) )


