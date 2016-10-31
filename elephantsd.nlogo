globals [ max-age circle-size]

turtles-own [ age gender tusk? ]

to setup
  ca

  set max-age 60 ;; agents can live up to max-age
  set circle-size 10 ;; bigger means smaller circles
  ask patches [ set pcolor brown + 4.9 ]

  crt total-population [


    ;; some initial values for every agent.

    set gender "male"
    set color red
    set shape "circle"
    set xcor random-xcor set ycor random-ycor
    set tusk? true
    set age random max-age
    set size age / circle-size ;; circle size grows with age.


    ;; initial gender distribution is 50%.
    ;; So we make half of the agents female.
    ;; Some of females are tuskless.

    if random 2 = 1
      [
        set gender "female"
        set color green
        if random 100 < ( initial-tusklessness * 2 ) [
          set tusk? false
          set color blue
        ]  ;; only females can be tuskless
      ]
  ]


  ;; check if we have any tuskless elephants

  if count turtles with [ tusk? = false ] < 1 and initial-tusklessness > 0
    [ setup ]

  reset-ticks
end

to go
  ask turtles [
    ;; give birth in every 6 years after certain age
    if count turtles < max-allowed-population and gender = "female" and age > female-maturation-age and age mod 6 = 0 [

      ;; some default values
      let offspring-gender "male"
      let offspring-color red
      let offspring-tusk true

        if random 2 = 1      ;; initial gender distribution is 50%
          [
            set offspring-gender "female"
            set offspring-color green

            ;; if mother is tuskless, child's chance of being tuskless is 50%.
            ;; because father is tusky.

            if tusk? = false and random 2 = 1 [
              set offspring-tusk false
              set offspring-color blue
            ]
          ]

      ;; hello world
      hatch 1 [
        set age 1
        set xcor random-xcor set ycor random-ycor
        set tusk? offspring-tusk
        set gender offspring-gender
        set color offspring-color
        ] ;; /hatch
    ] ;; / if
  ] ;; / give birth


  ;; increase age and adjust size accordingly
  ask turtles [
    set age age + 1
    set size age / circle-size
  ]


  ;; grown ones will be hunted for tusks

  ask turtles [
    if tusk? and age >= tusk-maturation-age and ( random 100 <= kill-rate ) [ die ]
  ]


  ;; die naturally from old age

  ask turtles [
    if age > max-age [ die ]
  ]

  tick


  ;; stop execution. extinction case.
  if count turtles with [ gender = "male" ] = 0 or count turtles with [ gender = "female" ] = 0 [ stop ]
end




;; Reset to initial values

to reset-to-defaults
  set initial-tusklessness 2
  set total-population 500
  set kill-rate 15
  set female-maturation-age 16
  set tusk-maturation-age 18
  set max-allowed-population 1000
end




;; for plotting. checks against errors such as division by zero.

to-report mean-age-tusky
  ifelse count turtles with [ tusk? ] > 0 [
    report mean [ age ] of turtles with [ tusk? ]
  ]
  [ report 0 ]
end

to-report mean-age-tuskless
  ifelse count turtles with [ tusk? = false ] > 0 [
    report mean [ age ] of turtles with [ tusk? = false ]
  ]
  [ report 0 ]
end

to-report mean-age-females
  ifelse count turtles with [ gender = "female" ] > 0 [
    report mean [ age ] of turtles with [ gender = "female" ]
  ]
  [ report 0 ]
end


to-report mean-age-males
  ifelse count turtles with [ gender = "male" ] > 0 [
    report mean [ age ] of turtles with [ gender = "male" ]
  ]
  [ report 0 ]
end

to-report tusklessness-ratio
  ifelse count turtles with [ tusk? = false ] > 0 [
    report count turtles with [ tusk? = false ] / count turtles * 100
  ]
  [ report 0 ]
end

to-report tusklessness-ratio-female-only
  ifelse count turtles with [ tusk? = false ] > 0 [
    report count turtles with [ tusk? = false ] / count turtles with [ gender = "female" ] * 100
  ]
  [ report 0 ]
end

to-report count-tuskless
  ifelse count turtles with [ tusk? = false ] > 0 [
    report count turtles with [ tusk? = false ]
  ]
  [ report 0 ]
end

to-report count-females
  ifelse count turtles with [ gender = "female" ] > 0 [
    report count turtles with [ gender = "female" ]
  ]
  [ report 0 ]
end

to-report count-males
  ifelse count turtles with [ gender = "male" ] > 0 [
    report count turtles with [ gender = "male" ]
  ]
  [ report 0 ]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
1024
445
100
50
4.0
1
10
1
1
1
0
1
1
1
-100
100
-50
50
0
0
1
ticks
30.0

BUTTON
14
257
189
290
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
124
306
187
339
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
14
10
186
43
initial-tusklessness
initial-tusklessness
0
100
2
1
1
NIL
HORIZONTAL

SLIDER
14
54
186
87
total-population
total-population
1
10000
500
1
1
NIL
HORIZONTAL

SLIDER
14
94
186
127
kill-rate
kill-rate
0
100
15
1
1
NIL
HORIZONTAL

BUTTON
15
306
125
339
go for 50 ticks
repeat 50 [ go ]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
1045
10
1245
160
Tuskless & Total Females
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Tuskless" 1.0 0 -13345367 true "" "plot count-tuskless"
"All Females" 1.0 0 -2674135 true "" "plot count-females"

PLOT
1047
173
1247
323
Males vs. Females
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Male" 1.0 0 -10899396 true "" "plot count-males"
"Female" 1.0 0 -2674135 true "" "plot count-females"

PLOT
814
460
1027
610
Tusklessness Ratio
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"In all population" 1.0 0 -16777216 true "" "plot tusklessness-ratio"
"Initial" 1.0 0 -13791810 true "" "plot initial-tusklessness"
"In females" 1.0 0 -2674135 true "" "plot tusklessness-ratio-female-only"

SLIDER
15
134
186
167
female-maturation-age
female-maturation-age
10
30
16
1
1
NIL
HORIZONTAL

SLIDER
15
175
187
208
tusk-maturation-age
tusk-maturation-age
5
30
18
1
1
NIL
HORIZONTAL

PLOT
353
458
575
608
Mean Age
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Tusky" 1.0 0 -7500403 true "" "plot mean-age-tusky"
"Tuskless" 1.0 0 -13345367 true "" "plot mean-age-tuskless"

PLOT
1048
340
1248
490
Population
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"Population" 1.0 0 -16777216 true "" "plot count-females + count-males"
"Max Allowed" 1.0 0 -2674135 true "" "plot max-allowed-population"

PLOT
580
459
805
610
Mean Age
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Male" 1.0 0 -10899396 true "" "plot mean-age-males"
"Female" 1.0 0 -2674135 true "" "plot mean-age-females"

TEXTBOX
213
458
383
560
Green	: Male Elephants\nRed	: Female Elephants\nBlue	: Tuskless Elephants\n\nCircle size indicates age.\nBigger means older.
12
0.0
1

BUTTON
15
412
193
445
Reset to defaults
reset-to-defaults
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
16
211
187
244
max-allowed-population
max-allowed-population
100
100000
500
100
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

This model is trying to explore how heavy poaching affects elephant population in Africa. This is an evolutionary biology model. The inspiration for this model is the work of Joyce Poole  on Gorongosa elephants.

"Ivory hunting was rampant in Gorongosa over the 15 years of Mozambique’s civil war, which ended in 1992. The war has reshaped Gorongosa’s elephant population in surprising ways, in what might be called an example of rapid natural (or unnatural) selection.

While virtually no male elephants are tuskless (they need tusks to fight), about 2 percent of female elephants are naturally tuskless. Among female elephants in Gorongosa who were adults during the civil war, however, half are tuskless—the others were simply killed. But tusklessness is an inheritable trait. That means that, even though poaching levels have fallen, a third of Gorongosa’s young female population is tuskless today."

More details and a video can be found here: http://nautil.us/issue/41/selection/how-an-elephant-loses-its-tusks

So our environment is elephants’ habitat, Gorongosa, Mozambique.

## HOW IT WORKS

Model implements one type of agent: Elephants.

Agents have 3 properties.

AGE: Age of an elephant used for determining maturation level of an elephant. It’s crucial for giving birth or being hunted for ivory.

GENDER: Male or female. Only female elephants can be tuskless.

TUSK?: True for tusky elephants and false for tuskless ones.

Female agents can give birth and depending on mother’s TUSK? property, the offspring can be tusky or tuskless.

Agents get one year older at every tick.

Some of tusky mature elephants get killed based on KILL-RATE.

Agents die because of old age when they reach a certain age.


Model starts with the initial elephant population, INITIAL-TUSKLESSNESS (initial natural tuskless elephant rate), KILL-RATE  (how many elephants killed every year for ivory), FEMALE-MATURATION-AGE (being able to give birth) and TUSK-MATURATION-AGE (being grown enough to be killed for ivory).

Every tick is one year. Every year births and deaths calculated according to mentioned variables. Females with tusks never give birth to tuskless offspring and tuskless females have 50 percent chance of giving birth to tuskless offspring, since males always have tusks. Model also considers dying of old age.

SETUP creates randomly distributed population according to initial variables.

Every tick is a year. Every year following events occur:

• Mature females give birth in every 6 years. New born’s properties determined by parent’s properties.
• Elephants get 1 year older.
• Mature tusky elephants get killed (Based on kill-rate.)
• Old elephants (over a certain age) die naturally.

If no male or female elephant left alive (Extinction) model stops execution.

## HOW TO USE IT

Model comes with default input values. For a quick start, just hit SETUP and then hit GO.

Inputs are as follows:

INITIAL-TUSKLESSNESS: Naturally 2% of elaphants are tuskless. This variable represents natural tusklessness ratio.

TOTAL-POPULATION: Starting population of elephants.

KILL-RATE: Effect of poaching. How many elephants being killed every year as a percentage of population.

FEMALE-MATURATION-AGE: At what age females can give birth.

TUSK-MATURATION-AGE: At what age elephants grow big enough tusks to be hunted.

MAX-ALLOWED-POPULATION: Upper limit of elephant population. Say, all other factors (such as vegetation, climate) embedded in this variable. You can think of it as "carrying capacity." Carrying capacity creates another evolutionary pressure over population besides poaching.

SETUP button prepares the environment and distributes initial population. Since ticks considered as years, to have a better control on passage of time I suggest to use GO FOR 50 TICKS button instead of GO. Hit GO FOR 50 TICKS a few times. After that, you can tweak input values. For instance you can lower KILL-RATE (indicates less poaching) and then hit GO FOR 50 TICKS again.

After tweaking, you can use RESET TO DEFAULTS button to go back to predetermined initial values.

Model automatically stops when no male or female elephant remains.

In the middle, we have the world as our main output medium. After setup, you will see our elephants distributed randomly. Elephants are represented as circles. Green ones are male, red ones are female and blue ones are tuskless elephants. As model executes, you will see elephants appear, grow and die. Circle size depends on age. So bigger circles indicate older elephants.

There are six plots on the screen as outputs.

MEAN-AGE plots: First one plots average age tusky and tuskless elephants. Second one show average ages based on gender.

TUSKLESSNESS-RATIO plot: You can observe groving of tuskless population here. Blue line indicates INITIAL-TUSKLESSNESS. Black line shows tuskless elephant percentage in all population and the red line shows tuskless percentage of female elephants.

TUSKLESS & TOTAL FEMALES: This plot shows tuskless vs all female population by actual numbers.

MALES VS FEMALES: This plot shows male and female population by actual numbers.

POPULATION: This plot show all elephant population by numbers.


## THINGS TO NOTICE

Size of the circles indicates age. Notice the size of blue circles and compare with others. You can see how fast big blue circles start to dominate view. Also you may check MEAN AGE plots.

Also notice, tusklessness won't grow forever, settless after a while. Notice how settling level related to MAX-ALLOWED-POPULATION (carrying capacity).

If you set MAX-ALLOWED-POPULATION too low, you should notice tusklessness ratio rises very strongly.

## THINGS TO TRY

Try to set KILL-RATE to 0. See how would be the natural state of elephant population.

Also try to set INITIAL-TUSKLESSNESS to 0 and see what would happen if elephants haven't had this mutation.

Try to tweak maturation sliders to see the relation between the two.

Finally, try to rise KILL-RATE all the way up to 100%, meaning poachers kill every mature elephant with tusk and witness the power of this surviving strategy.

Try going for 100 - 200 ticks with high (such as 15%) KILL-RATE and then going for another 100 with lower KILL-RATE (maybe 7%). See the long term effect of an era of heavy poaching.

Try to rise MAX-ALLOWED-POPULATION all the way up to 100,000 to simulate no upper bound case. See the results.

## EXTENDING THE MODEL

In the end, this is somewhat naive implementation of real phenomena. Real-life population and poaching data can be integrated into the model. Reproduction behaviour also may have nuances. Other causes of natural deaths can be considered.

## NETLOGO FEATURES

Model built with basic tools provided by NetLogo. TO-REPORT command was helpful to avoid runtime errors.

## RELATED MODELS

Model seems to stand between "Peppered Moths" and "Wolf Sheep Predation".

## CREDITS AND REFERENCES

2016, Uğur

No animals were harmed in the making of this model.

You can use model as you like. No restrictions whatsoever.

* http://nautil.us/issue/41/selection/how-an-elephant-loses-its-tusks
* https://www.awf.org/blog/going-tuskless
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.3.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
