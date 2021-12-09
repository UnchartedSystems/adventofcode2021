(ns p5
  (:require [clojure.string :as string]
            [i5 :as i]))


(defn mass-replace [str & vec]
  (reduce #(apply string/replace %1 %2) str vec))

(defn- convert-input [str]
  (map read-string (string/split (mass-replace str ["," " "] [" -> " " "] ["\n" " "]) #" ")))

(defn- structure-input [vec]
  (let [order #(vector (vector (nth % 0) (nth % 2)) (vector (nth % 1) (nth % 3)))]
    (reduce #(conj %1 (order %2)) [] (partition 4 vec))))

(structure-input (convert-input i/e-string))

(defn- make-coords [f v]
  (reduce #(conj %1 (f %2)) [] (range (apply min v) (inc (apply max v)))))

(defn- make-diag [x1 x2 y1 y2]
  (let [inc-dec? #(if (> %1 %2) -1 1 )
        x-step (inc-dec? x1 x2)
        y-step (inc-dec? y1 y2)]
    (mapv #(vector %1 %2) (range x1 (+ x2 x-step) x-step) (range y1 (+ y2 y-step) y-step))))

(defn- line->coords [line diag?]
  (let [x (first line)
        y (second line)]
    (cond (apply = x)   (make-coords #(vector (first x) %) y)
          (apply = y)   (make-coords #(vector % (first y)) x)
          diag?         (apply make-diag (flatten line))
          :else         (print "error"))))

(defn- vent-scan [input diag?]
  (let [lines       (structure-input (convert-input input))
        raw-coords  (map #(line->coords % diag?) lines)
        coords      (partition 2 (filter some? (flatten raw-coords)))
        collisions  (filter #(> (second %) 1) (frequencies coords))]
    (count collisions)))

(vent-scan i/input-string false)
(vent-scan i/input-string true)
