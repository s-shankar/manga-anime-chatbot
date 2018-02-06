adjectives = """
able capable
absent-minded carefree careless dreamy forgetful
active 
adventurous 
affable charismatic charming
affected 
affectionate caring compassionate considerate kind kindly loving
afraid anxious concerned
aggressive 
alert attentive
ambitious 
amiable 
angry furious hateful hating
animated 
annoyed 
apologetic 
appreciative 
argumentative 
arrogant boastful blowhard conceited 
austere 
average 
awkward bashful clumsy

babyish
bad
beautiful handsome
bewildered
blasé bored
bold brave courageous dauntless fearless intrepid
boorish brutish coarse
bossy domineering
brainy bright brilliant clever intelligent sharp sharp-witted shrewd smart
busy

calm
candid innocent
careful
caustic
cautious prudent
cheerful
changeable
civilized civilised
cold-hearted disaffected
commitment-phobe
committed
communicative
competent dependable expert
complacent content contented
confident
confused dismayed
consistent
cooperative
cowardly
crafty resourceful
creative imaginative inventive
critical 
cross disloyal
cruel
cultured
curious

dainty
dangerous
dark
decisive
despondent discouraged
deferential
demanding
depressed 
desiccated
determined
devoted
diligent dutiful hard-working industrious
disagreeable
discerning
discontent discontented dissatisfied
discreet
dishonest
disillusioned
disorganized
disparaging disrespectful
distressed
doubtful
dreamer
dull foolish

eager
easygoing easy-going
effervescent energetic
efficient
eloquent
embarrassed
encouraging
enthusiastic
equable
ethical
evil
exacting
excessive
excitable excited
exuberant

facetious
faithful
faithless
fanciful
fearful frightened scared
feisty
ferocious
fidgety
fierce
fighter
finicky
flexible
forgiving
formal
fortunate lucky
foul
frank
fresh
friendly
frustrated
fun-loving
funny
fussy

garrulous
generous
gentle
giddy
giving
glamorous
gloomy
glum
good
graceful
greedy
gregarious
grouchy
grumpy
guilty
gullible naïve naive

happy jovial joyful
hardy
harried
harsh
haughty
healthy
helpful
hesitant
honest
hopeless
hopeful
hospitable
hot-tempered
humble meek
humorous

ignorant
ill-bred
immaculate
immature
immobile
impartial
impatient
impolite
impudent
impulsive
inactive
inconsiderate
inconsistent
indecisive
independent
indiscriminate
indolent
inefficient
inimitable
insecure
insincere
insipid
insistent
insolent
intolerant

jealous
jolly

keen


lackadaisical
languid
lazy
leader
lean
left-brain
liar
licentious
light
light-hearted
limited
lively
logical rational
lonely
loquacious
loud
lovable
loyal

malicious
mannerly
mature
mean
merciful
messy
meticulous
mischievous
miserable
moody
mysterious

nagging
naughty
neat
negligent
nervous
nice
noisy

obedient
obliging
observant
open
optimistic positive
organised
outspoken

patient
patriotic
peaceful
perserverant
persistent
persuasive
perverse
pessimistic
picky
pitiful
plain
playful
pleasant
pleasing
polite
poor
popular
precise
pretty
primitive
proper
proud
punctual
purposeful

quarrelsome
quick
quick-tempered
quiet reserved

reasonable
reckless
relaxed
reliable
religious
repugnant repulsive
respectful
responsible
restless
rich
rigid
risk-taking
rough
rowdy
rude
ruthless

sad
safe
satisfied
scatty
scheming
scrawny
scruffy
secretive
secure
self-centered
self-confident
self-controlling
selfish
sensitive
sentimental
serious
shiftless
short
shy
silly
simple
simple-minded
sincere
single-minded
skillful
sly
sneaky
soft-hearted
solitary
sorry
spendthrift
spoiled
sterile
stern
stingy
strange
strict
strong
stubborn
studious
submissive
successful
superstitious
supportive
suspicious
sweet

tactful
tactless
talented
talkative
tall
tardy
temperate
thankful
thorough
thoughtful
thoughtless
thrifty
thrilled
timid
tired
tireless
tolerant
touchy
tough
trusting
trustworthy
truthful

ugly
unconcerned
uncoordinated
undependable
understanding
unforgiving
unfriendly
ungrateful
unhappy
unkind
unmerciful
unselfish
unsuitable
upset
useful

vacant
violent
virtuous

warm
weak
wicked
wild
wise
wishy-washy
withdrawn
witty
worried
wrong

young

zany
"""

print("return {")

for i in adjectives.split("\n"):
	if i == "" :
		print()
		continue
	line = "	{"
	for j in i.split(" ") :
		if j != "":
			line+="\""+j+"\", "
	line += "},"
	print(line)
print("}")
