(ns lp-parser-emitter.destinations
  (:gen-class)
  (:require [clojure.data.xml :as xml]
            [clojure.zip :as zip]
            [clojure.data.zip.xml :as zip-xml]
            [clojure.string :as string]))

(defn lazy-xml
  "Given a file path, yields a lazy seq of XML."
  [file-path]
  (-> file-path
      (clojure.java.io/make-input-stream {})
      xml/parse
      zip/xml-zip))

(defn destinations
  "Given a lazy seq of XML, lazily yield parsed destinations."
  [dest-xml]
  (zip-xml/xml-> dest-xml :destination))

(defn find-destination
  "Given a lazy seq of XML and a destination title, yield a destination node
   whose title matches the provided title."
  [dest-xml title]
  (zip-xml/xml1-> dest-xml
                  destinations
                  (zip-xml/attr= :title title)))

(defn title
  "Given a destination node, return it's title."
  [dest-node]
  (zip-xml/attr dest-node :title))

(defn filename
  "Given a destination node, return it's title."
  [dest-node]
  (-> dest-node
      title
      string/lower-case
      (string/replace #"\W" "_")
      (str ".html")))

