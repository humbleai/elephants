# WHAT IS IT?

This model is trying to explore how heavy poaching affects elephant population in Africa. The inspiration for this model is the work of Joyce Poole  on Gorongosa elephants.

<blockquote>You will need NetLogo to be able to run the model. NetLogo is a multi-agent programmable modeling environment. It is used by tens of thousands of students, teachers and researchers worldwide. It also powers HubNet participatory simulations. It is authored by Uri Wilensky and developed at the CCL. You can download it free of charge. Download here: https://ccl.northwestern.edu/netlogo/</blockquote>

"Ivory hunting was rampant in Gorongosa over the 15 years of Mozambique’s civil war, which ended in 1992. The war has reshaped Gorongosa’s elephant population in surprising ways, in what might be called an example of rapid natural (or unnatural) selection.

While virtually no male elephants are tuskless (they need tusks to fight), about 2 percent of female elephants are naturally tuskless. Among female elephants in Gorongosa who were adults during the civil war, however, half are tuskless—the others were simply killed. But tusklessness is an inheritable trait. That means that, even though poaching levels have fallen, a third of Gorongosa’s young female population is tuskless today."

More details and a video can be found here: http://nautil.us/issue/41/selection/how-an-elephant-loses-its-tusks

# HOW IT WORKS

It starts with the initial elephant population, initial natural tuskless elephant rate, kill rate  (how many elephants killed every year for ivory), female maturation age (being able to give birth) and tusk maturation age (being grown enough to be killed for ivory).

Every tick is one year. Every year births and deaths calculated according to mentioned variables. Females with tusks never give birth to tuskless offspring and tuskless females have 50 percent chance of giving birth to tuskless offspring, since males always have tusks. Model also considers dying of old age.

# HOW TO USE IT

initial-tusklessness: Naturally 2% of elaphants are tuskless. This variable represents natural tusklessness ratio.

total-population: Starting population of elephants.

kill-rate: Effect of poaching. How many elephants being killed every year as a percentage of population.

female-maturation-age: At what age females can give birth.

tusk-maturation-age: At what age elephants grow big enough tusks to be hunted.

max-allowed-population: Upper limit of elephant population. Say, all other factors (such as vegetation, climate) embedded in this variable. You can think of it as "carrying capacity." Carrying capacity creates another evolutionary pressure over population besides poaching.

Default values gathered from different sources. You can play around this values and see interesting results.

## THINGS TO NOTICE

Size of the circles indicates age. Notice size of blue circles and compare with others. You can see how fast big blue circles starts to dominate view. Also you may check "Mean Age" plots.

Also notice, tusklessness won't grow forever, settless after a while. Notice how settling level related to max-allowed-population (carrying capacity).

If you set max-allowed-population too low, you should notice tusklessness ratio rises very strongly.

## THINGS TO TRY

Set kill-rate to 0. See how would be the natural state of elephant population.

Also try setting initial-tusklessness to 0 and see what would happen if elephants haven't had this mutation.

Tweak maturation sliders to see the relation between the two.

Finally, rise kill-rate all the way up to 100%, meaning poachers kill every mature elephant with tusk and witness the power of this surviving strategy.

Try going for 100 - 200 ticks with high (such as 15%) kill rate and then going for another 100 with lower kill rate (maybe 7%). See the long term effect of an era of heavy poaching.

Try rising max-allowed-population all the way up to 100,000, to simulate no upper bound. See the results.

# EXTENDING THE MODEL

In the end, this is somewhat naive implementation of real phenomena. Real-life population and poaching data can be integrated into the model. Reproduction behaviour also may have nuances. Other causes of natural deaths can be considered.

# NETLOGO FEATURES

Model built with basic tools provided by NetLogo. to-report command was helpful to avoid runtime errors.

# RELATED MODELS

Model seems to stand between "Peppered Moths" and "Wolf Sheep Predation".

# CREDITS AND REFERENCES

2016, humbleai

No animals were harmed in the making of this model.

You can use model as you like. No restrictions whatsoever.

* http://nautil.us/issue/41/selection/how-an-elephant-loses-its-tusks
* https://www.awf.org/blog/going-tuskless
