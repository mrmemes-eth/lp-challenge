(ns lp-parser-emitter.xml
  (:gen-class)
  (:require [clojure.data.xml :as xml]
            [clojure.zip :as zip]))

(defn lazy
  "Given a file path, yields a lazy seq of XML."
  [file-path]
  (-> file-path
      (clojure.java.io/make-input-stream {})
      xml/parse
      zip/xml-zip))

