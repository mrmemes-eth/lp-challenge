(ns lp-parser-emitter.destinations
  (:gen-class)
  (:require [clojure.data.xml :as xml]
            [clojure.zip :as zip]
            [clojure.data.zip.xml :as zip-xml]))

(defn lazy-xml [file-path]
  (-> file-path
      (clojure.java.io/make-input-stream {})
      xml/parse
      zip/xml-zip))

(defn find-destination [dest-xml title]
  (zip-xml/xml1-> dest-xml
                  :destination
                  (zip-xml/attr= :title title)))
