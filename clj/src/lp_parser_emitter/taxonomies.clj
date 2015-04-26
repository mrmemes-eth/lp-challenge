(ns lp-parser-emitter.taxonomies
  (:gen-class)
  (:require [clj-xpath.core :as xp]
            [lp-parser-emitter.xml :as xml]))

(defn find-node
  "Given a taxonomy xml string and a name, find a node with the name specified."
  [tax-xml node-name]
  (-> (str "//node[node_name[text()='" node-name "']]")
      (xp/$x tax-xml)
      first))

(defn node-name
  "Given a node, returns the value of it's child node_name."
  [node]
  (xp/$x:text "./node_name" node))

(defn parent
  "Given a node, return its parent node."
  [node]
  (-> "./parent::node" (xp/$x node) first))

(defn children
  [node]
  (xp/$x "./child::node" node))

