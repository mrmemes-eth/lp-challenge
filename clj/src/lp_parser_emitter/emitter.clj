(ns lp-parser-emitter.emitter
  (:gen-class)
  (require [lp-parser-emitter.destinations :as dest]
           [clojure.java.io :as io]))

(defn- prepare-build-dir
  "Ensures the build directory is present and removes any files currently in it."
  [output-directory]
  (when-not  (.mkdir (java.io.File. output-directory))
    ; we take rest, since file-seq includes the directory in the first position
    (doseq [file (rest (file-seq (io/file output-directory)))]
      (io/delete-file file)))
  ; put the css file in place
  (let [css "all.css"]
    (io/copy (io/file (io/resource css))
             (io/file output-directory css))))

(defn spit-html
  "takes a lazy-seq of destinations and a directory to build to and emits an
   HTML file for each destination."
  [destinations output-directory]
  (prepare-build-dir output-directory)
  (let [template (io/resource "template.html")]
    (doseq [destination destinations]
      (let [filename (dest/filename destination)
            file (io/file output-directory filename)]
        (spit file (slurp template))))))
