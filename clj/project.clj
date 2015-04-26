(defproject lp-parser-emitter "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.7.0-beta1"]
                 [org.clojure/data.xml "0.0.8"]
                 [org.clojure/data.zip "0.1.1"]
                 [org.clojure/tools.cli "0.3.1"]
                 [clj-time "0.9.0"]
                 [com.github.kyleburton/clj-xpath "1.4.4"]
                 [selmer "0.8.2"]]
  :plugins [[lein-bin "0.3.5"]]
  :bin {:name "lp-process"
        :bin-path "bin"}
  :main lp-parser-emitter.core
  :aot :all
  :bootclasspath true)
