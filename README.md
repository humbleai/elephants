
# WHAT IS IT?

This model is trying to explore how heavy poaching affects elephant population in Africa. This is an evolutionary biology model. The inspiration for this model is the work of Joyce Poole  on Gorongosa elephants.

<blockquote>You will need NetLogo to be able to run the model. NetLogo is a multi-agent programmable modeling environment. It is used by tens of thousands of students, teachers and researchers worldwide. It also powers HubNet participatory simulations. It is authored by Uri Wilensky and developed at the CCL. You can download it free of charge. Download here:
https://ccl.northwestern.edu/netlogo/</blockquote>

"Ivory hunting was rampant in Gorongosa over the 15 years of Mozambique’s civil war, which ended in 1992. The war has reshaped Gorongosa’s elephant population in surprising ways, in what might be called an example of rapid natural (or unnatural) selection.

While virtually no male elephants are tuskless (they need tusks to fight), about 2 percent of female elephants are naturally tuskless. Among female elephants in Gorongosa who were adults during the civil war, however, half are tuskless—the others were simply killed. But tusklessness is an inheritable trait. That means that, even though poaching levels have fallen, a third of Gorongosa’s young female population is tuskless today."

More details and a video can be found here: http://nautil.us/issue/41/selection/how-an-elephant-loses-its-tusks

So our environment is elephants’ habitat, Gorongosa, Mozambique.

# HOW IT WORKS

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

# HOW TO USE IT

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


# THINGS TO NOTICE

Size of the circles indicates age. Notice the size of blue circles and compare with others. You can see how fast big blue circles start to dominate view. Also you may check MEAN AGE plots.

Also notice, tusklessness won't grow forever, settless after a while. Notice how settling level related to MAX-ALLOWED-POPULATION (carrying capacity).

If you set MAX-ALLOWED-POPULATION too low, you should notice tusklessness ratio rises very strongly.

# THINGS TO TRY

Try to set KILL-RATE to 0. See how would be the natural state of elephant population.

Also try to set INITIAL-TUSKLESSNESS to 0 and see what would happen if elephants haven't had this mutation.

Try to tweak maturation sliders to see the relation between the two.

Finally, try to rise KILL-RATE all the way up to 100%, meaning poachers kill every mature elephant with tusk and witness the power of this surviving strategy.

Try going for 100 - 200 ticks with high (such as 15%) KILL-RATE and then going for another 100 with lower KILL-RATE (maybe 7%). See the long term effect of an era of heavy poaching.

Try to rise MAX-ALLOWED-POPULATION all the way up to 100,000 to simulate no upper bound case. See the results.

# EXTENDING THE MODEL

In the end, this is somewhat naive implementation of real phenomena. Real-life population and poaching data can be integrated into the model. Reproduction behaviour also may have nuances. Other causes of natural deaths can be considered.

# NETLOGO FEATURES

Model built with basic tools provided by NetLogo. TO-REPORT command was helpful to avoid runtime errors.

# RELATED MODELS

Model seems to stand between "Peppered Moths" and "Wolf Sheep Predation".

# CREDITS AND REFERENCES

2016, humbleai Ugur

No animals were harmed in the making of this model.

You can use model as you like. No restrictions whatsoever.

* http://nautil.us/issue/41/selection/how-an-elephant-loses-its-tusks
* https://www.awf.org/blog/going-tuskless
