# LOAD PACKAGES
using Pkg

Pkg.add("CSV")
Pkg.add("DataFrames")
Pkg.add("FreqTables")
Pkg.add("GLM")
Pkg.add("HTTP")
Pkg.add("HypothesisTests")
Pkg.add("JLD2") # for saving any Julia object; successor to JLD; use to save working data or other object
Pkg.add("MLJBase")
Pkg.add("Missings")
Pkg.add("Plots")
Pkg.add("StatsKit") # meta-package that loads packages associated with JuliaStats, including CSV, DataFrames, GLM, HypothesisTests,
#and MultivariateStats
# note: unclear which packages loaded automatically; I used StatsKit without loading CSV directly, and then CSV not available
Pkg.add("StatsPlots")
Pkg.add("Tables")

## Open installed packages
using CSV, DataFrames, FreqTables, GLM, HTTP, HypothesisTests, JLD, Missings, MLJBase, Plots, StatsKit, StatsPlots, Tables

# check julia version
VERSION

pwd()

path = "/home/jovyan/"
cd(path)
# or cd("..")

pwd()

mkdir("./code")

mkdir("./data")

mkdir("./figures")

mkdir("./tables")

readdir()

# if loading from file in data folder (use CSV and DataFrame together)
df1 = CSV.read("./data/original/metoo_data.csv", DataFrame)

# can index within DataFrame
# e.g., 
# row = df1[1,:]

# inspect first 5 rows and first 3 cols
df1[1:5,1:3]

describe(df1)

# create and transform new var condition2
df1.condition2 = ""

df1[(df1[:condition] .== 1),:condition2]="Jokes"
df1[(df1[:condition] .== 2),:condition2]="Assault"
df1[(df1[:condition] .== 3),:condition2]="Control"

# check values
df1[1:5,:condition2]

# make categorical
df1[:condition2] = CategoricalArray(df1[:condition2])

# check levels
levels(df1[:condition2])

# reorder levels
levels!(df1[:condition2], ["Control", "Jokes", "Assault"])
# exclamation mark (!) after function replaces object in place

# recheck levels
levels(df1[:condition2])

# create and transform new var pid3
# check tabulation (values)
freqtable(df1.pid7)

df1.pid3 = ""
df1[(df1[:pid7] .== "Lean Democrat"),:pid3]="Democrat"
df1[(df1[:pid7] .== "Strong Democrat"),:pid3]="Democrat"
df1[(df1[:pid7] .== "Not very strong Democrat"),:pid3]="Democrat"

df1[(df1[:pid7] .== "Lean Republican"),:pid3]="Republican"
df1[(df1[:pid7] .== "Strong Republican"),:pid3]="Republican"
df1[(df1[:pid7] .== "Not very strong Republican"),:pid3]="Republican"

df1[(df1[:pid7] .== "Independent"),:pid3]="Independent"
df1[(df1[:pid7] .== "Not sure"),:pid3]="Independent"

# make categorical
df1[:pid3] = CategoricalArray(df1[:pid3])

describe(df1)

# recode: punishment 

# punishment 1
freqtable(df1.punishment_1)

# var contains 'missing', which will not process in ==/> kind of functions, so need to recode missing first as ""
df1.punishment_1b = df1.punishment_1
df1.punishment_1b = Missings.replace(df1.punishment_1b, "")

# recode: punishment 

# punishment 1
df1.needmoreevidence = 999
df1[(df1[:punishment_1b] .== "Agree strongly"),:needmoreevidence]=5
df1[(df1[:punishment_1b] .== "Agree somewhat"),:needmoreevidence]=4
df1[(df1[:punishment_1b] .== "Neither disagree nor agree"),:needmoreevidence]=3
df1[(df1[:punishment_1b] .== "Disagree somewhat"),:needmoreevidence]=2
df1[(df1[:punishment_1b] .== "Disagree strongly"),:needmoreevidence]=1

# now recode 999 as missing so future fxn will skip over
df1[:needmoreevidence] = recode(df1[:needmoreevidence], 999=>missing)

freqtable(df1.needmoreevidence, df1.punishment_1)

# punishment 2 (to 'apology')
freqtable(df1.punishment_2)

# var contains 'missing', which will not process in ==/> kind of functions, so need to recode missing first as ""
df1.punishment_2b = df1.punishment_2
df1.punishment_2b = Missings.replace(df1.punishment_2b, "")

df1.apology = 999
df1[(df1[:punishment_2b] .== "Agree strongly"),:apology]=5
df1[(df1[:punishment_2b] .== "Agree somewhat"),:apology]=4
df1[(df1[:punishment_2b] .== "Neither disagree nor agree"),:apology]=3
df1[(df1[:punishment_2b] .== "Disagree somewhat"),:apology]=2
df1[(df1[:punishment_2b] .== "Disagree strongly"),:apology]=1

# recode 999 as missing
df1[:apology] = recode(df1[:apology], 999=>missing)
freqtable(df1.apology, df1.punishment_2)

# punishment 3 (to 'longtimeago')
freqtable(df1.punishment_3)

# var contains 'missing', which will not process in ==/> kind of functions, so need to recode missing first as ""
df1.punishment_3b = df1.punishment_3
df1.punishment_3b = Missings.replace(df1.punishment_3b, "")

df1.longtimeago = 999
df1[(df1[:punishment_3b] .== "Agree strongly"),:longtimeago]=5
df1[(df1[:punishment_3b] .== "Agree somewhat"),:longtimeago]=4
df1[(df1[:punishment_3b] .== "Neither disagree nor agree"),:longtimeago]=3
df1[(df1[:punishment_3b] .== "Disagree somewhat"),:longtimeago]=2
df1[(df1[:punishment_3b] .== "Disagree strongly"),:longtimeago]=1

# recode 999 as missing
df1[:longtimeago] = recode(df1[:longtimeago], 999=>missing)
freqtable(df1.longtimeago, df1.punishment_3)

# punishment 4 (to 'resign')
freqtable(df1.punishment_4)

# var contains 'missing', which will not process in ==/> kind of functions, so need to recode missing first as ""
df1.punishment_4b = df1.punishment_4
df1.punishment_4b = Missings.replace(df1.punishment_4b, "")

df1.resign = 999
df1[(df1[:punishment_4b] .== "Agree strongly"),:resign]=5
df1[(df1[:punishment_4b] .== "Agree somewhat"),:resign]=4
df1[(df1[:punishment_4b] .== "Neither disagree nor agree"),:resign]=3
df1[(df1[:punishment_4b] .== "Disagree somewhat"),:resign]=2
df1[(df1[:punishment_4b] .== "Disagree strongly"),:resign]=1

# recode 999 as missing
df1[:resign] = recode(df1[:resign], 999=>missing)
freqtable(df1.resign, df1.punishment_4)

# punishment 5 (to 'elitecues')
freqtable(df1.punishment_5)

# var contains 'missing', which will not process in ==/> kind of functions, so need to recode missing first as ""
df1.punishment_5b = df1.punishment_5
df1.punishment_5b = Missings.replace(df1.punishment_5b, "")

df1.elitecues = 999
df1[(df1[:punishment_5b] .== "Agree strongly"),:elitecues]=5
df1[(df1[:punishment_5b] .== "Agree somewhat"),:elitecues]=4
df1[(df1[:punishment_5b] .== "Neither disagree nor agree"),:elitecues]=3
df1[(df1[:punishment_5b] .== "Disagree somewhat"),:elitecues]=2
df1[(df1[:punishment_5b] .== "Disagree strongly"),:elitecues]=1

# recode 999 as missing
df1[:elitecues] = recode(df1[:elitecues], 999=>missing)
freqtable(df1.elitecues, df1.punishment_5)

#############################
# recode punishment: reverse codes
#############################

# need more evidence
df1.needmoreevidence_reverse = 999
df1[(df1[:punishment_1b] .== "Agree strongly"),:needmoreevidence_reverse]=1
df1[(df1[:punishment_1b] .== "Agree somewhat"),:needmoreevidence_reverse]=2
df1[(df1[:punishment_1b] .== "Neither disagree nor agree"),:needmoreevidence_reverse]=3
df1[(df1[:punishment_1b] .== "Disagree somewhat"),:needmoreevidence_reverse]=4
df1[(df1[:punishment_1b] .== "Disagree strongly"),:needmoreevidence_reverse]=5

# now recode 999 as missing so future fxn will skip over
df1[:needmoreevidence_reverse] = recode(df1[:needmoreevidence_reverse], 999=>missing)

freqtable(df1.needmoreevidence_reverse, df1.punishment_1)

# long time ago
df1.longtimeago_reverse = 999
df1[(df1[:punishment_3b] .== "Agree strongly"),:longtimeago_reverse]=1
df1[(df1[:punishment_3b] .== "Agree somewhat"),:longtimeago_reverse]=2
df1[(df1[:punishment_3b] .== "Neither disagree nor agree"),:longtimeago_reverse]=3
df1[(df1[:punishment_3b] .== "Disagree somewhat"),:longtimeago_reverse]=4
df1[(df1[:punishment_3b] .== "Disagree strongly"),:longtimeago_reverse]=5

# recode 999 as missing
df1[:longtimeago_reverse] = recode(df1[:longtimeago_reverse], 999=>missing)
freqtable(df1.longtimeago_reverse, df1.punishment_3)

# new variable: mean punitiveness score ####
df1[:meanpunishment] = ((df1[:apology]+df1[:resign]+df1[:needmoreevidence_reverse]+df1[:longtimeago_reverse])/4)

describe(df1.meanpunishment)

## new variable: same party as legislator####
freqtable(df1.senator_party, df1.senator_party)

df1.sameparty = ""
df1[( (df1[:pid3] .== "Democrat") .& (df1[:senator_party] .== "Democrat") ) .|
    ( (df1[:pid3] .== "Republican") .& (df1[:senator_party] .== "Republican") ),:sameparty] ="Same party"

df1[( (df1[:pid3] .== "Democrat") .& (df1[:senator_party] .== "Republican") ) .|
    ( (df1[:pid3] .== "Republican") .& (df1[:senator_party] .== "Democrat") ),:sameparty] ="Opposite party"

df1[(df1[:pid3] .== "Independent"),:sameparty] = "Independents/Not sures" 

#make categorical
df1[:sameparty] = CategoricalArray(df1[:sameparty])

freqtable(df1.sameparty)

# recode: pre sexism ####
# sexism_1,2,4 reverse coded
# see original R code from authors

# tried using recode and dictionaries, but could not get it to work
# instead, generated simple numeric based on values of pre_sexism_#

#df1.pre_sexism_1new = recode(df1.pre_sexism_1, 
#    5=>"Agree strongly",
#    4=>"Agree somewhat",
#    3=>"Neither disagree nor agree",
#    2=>"Disagree somewhat",
#    1=>"Disagree strongly")

# alt: could use dictionary: A = Categorical([1 2;2 1;2 2;1 1], Dict(1=>"male", 2=>"female"))

df1.pre_sexism_1new = 999
df1[ (df1[:pre_sexism_1] .== "Agree strongly"),:pre_sexism_1new] =5
df1[ (df1[:pre_sexism_1] .== "Agree somewhat"),:pre_sexism_1new] =4
df1[ (df1[:pre_sexism_1] .== "Neither disagree nor agree"),:pre_sexism_1new] =3
df1[ (df1[:pre_sexism_1] .== "Disagree somewhat"),:pre_sexism_1new] =2
df1[ (df1[:pre_sexism_1] .== "Disagree strongly"),:pre_sexism_1new] =1
freqtable(df1.pre_sexism_1new)

df1.pre_sexism_2new = 999
df1[ (df1[:pre_sexism_2] .== "Agree strongly"),:pre_sexism_2new] =5
df1[ (df1[:pre_sexism_2] .== "Agree somewhat"),:pre_sexism_2new] =4
df1[ (df1[:pre_sexism_2] .== "Neither disagree nor agree"),:pre_sexism_2new] =3
df1[ (df1[:pre_sexism_2] .== "Disagree somewhat"),:pre_sexism_2new] =2
df1[ (df1[:pre_sexism_2] .== "Disagree strongly"),:pre_sexism_2new] =1
freqtable(df1.pre_sexism_2new)

df1.pre_sexism_4new = 999
df1[ (df1[:pre_sexism_4] .== "Agree strongly"),:pre_sexism_4new] =5
df1[ (df1[:pre_sexism_4] .== "Agree somewhat"),:pre_sexism_4new] =4
df1[ (df1[:pre_sexism_4] .== "Neither disagree nor agree"),:pre_sexism_4new] =3
df1[ (df1[:pre_sexism_4] .== "Disagree somewhat"),:pre_sexism_4new] =2
df1[ (df1[:pre_sexism_4] .== "Disagree strongly"),:pre_sexism_4new] =1
freqtable(df1.pre_sexism_4new)

df1.pre_sexism_3new = 999
df1[ (df1[:pre_sexism_3] .== "Agree strongly"),:pre_sexism_3new] =1
df1[ (df1[:pre_sexism_3] .== "Agree somewhat"),:pre_sexism_3new] =2
df1[ (df1[:pre_sexism_3] .== "Neither disagree nor agree"),:pre_sexism_3new] =3
df1[ (df1[:pre_sexism_3] .== "Disagree somewhat"),:pre_sexism_3new] =4
df1[ (df1[:pre_sexism_3] .== "Disagree strongly"),:pre_sexism_3new] =5
freqtable(df1.pre_sexism_3new)

# new variable: pre_sexism ####
df1[:pre_sexism] = ((df1[:pre_sexism_1new] + df1[:pre_sexism_2new] + df1[:pre_sexism_3new] + df1[:pre_sexism_4new])/4)

# recode post_sexism
# sexism_1,2,4 reverse coded (same as pre_sexism)
# see original R code from authors

df1.post_sexism_1new = 999
df1[ (df1[:post_sexism_1] .== "Agree strongly"),:post_sexism_1new] =5
df1[ (df1[:post_sexism_1] .== "Agree somewhat"),:post_sexism_1new] =4
df1[ (df1[:post_sexism_1] .== "Neither disagree nor agree"),:post_sexism_1new] =3
df1[ (df1[:post_sexism_1] .== "Disagree somewhat"),:post_sexism_1new] =2
df1[ (df1[:post_sexism_1] .== "Disagree strongly"),:post_sexism_1new] =1

df1.post_sexism_2new = 999
df1[ (df1[:post_sexism_2] .== "Agree strongly"),:post_sexism_2new] =5
df1[ (df1[:post_sexism_2] .== "Agree somewhat"),:post_sexism_2new] =4
df1[ (df1[:post_sexism_2] .== "Neither disagree nor agree"),:post_sexism_2new] =3
df1[ (df1[:post_sexism_2] .== "Disagree somewhat"),:post_sexism_2new] =2
df1[ (df1[:post_sexism_2] .== "Disagree strongly"),:post_sexism_2new] =1

df1.post_sexism_4new = 999
df1[ (df1[:post_sexism_4] .== "Agree strongly"),:post_sexism_4new] =5
df1[ (df1[:post_sexism_4] .== "Agree somewhat"),:post_sexism_4new] =4
df1[ (df1[:post_sexism_4] .== "Neither disagree nor agree"),:post_sexism_4new] =3
df1[ (df1[:post_sexism_4] .== "Disagree somewhat"),:post_sexism_4new] =2
df1[ (df1[:post_sexism_4] .== "Disagree strongly"),:post_sexism_4new] =1

df1.post_sexism_3new = 999
df1[ (df1[:post_sexism_3] .== "Agree strongly"),:post_sexism_3new] =1
df1[ (df1[:post_sexism_3] .== "Agree somewhat"),:post_sexism_3new] =2
df1[ (df1[:post_sexism_3] .== "Neither disagree nor agree"),:post_sexism_3new] =3
df1[ (df1[:post_sexism_3] .== "Disagree somewhat"),:post_sexism_3new] =4
df1[ (df1[:post_sexism_3] .== "Disagree strongly"),:post_sexism_3new] =5

# new variable: post_sexism ####
df1[:post_sexism] = ((df1[:post_sexism_1new] + df1[:post_sexism_2new] + df1[:post_sexism_3new] + df1[:post_sexism_4new])/4)

### new variables: 
# raw change from pretest to posttest ####
# favorability
df1[:change_favorability] = (df1.post_favorability.+1) - (df1.pre_favorability.+1)

# vote
df1[:change_vote] = (df1.post_vote) - (df1.pre_vote)

# sexism
df1[:change_sexism] = (df1.post_sexism) - (df1.pre_sexism)

### new variables: 
# percent change from pretest to posttest ##### favorability
df1[:perchange_favorability] = (((df1[:post_favorability].+1) - (df1[:pre_favorability].+1))./(df1[:pre_favorability].+1))*100

# vote
df1[:perchange_vote] = (((df1.post_vote.+1) - (df1.pre_vote.+1))./(df1.pre_vote.+1))*100

# sexism
df1[:perchange_sexism] = (((df1[:post_sexism].+1) - (df1[:pre_sexism].+1))./(df1[:pre_sexism].+1))*100

# subset: without independents/notsures 
partydat = df1[(df1[:sameparty] .!= "Independents/Not sures"),:]

# subset: people that share party with senator, people that do not share party with senator
samepartydat = df1[(df1[:sameparty] .!= "Same party"),:]
opppartydat = df1[(df1[:sameparty] .!= "Opposite party"),:]

# Means
describe(df1[:post_favorability][df1.condition2 .== "Control"])

describe(df1[:post_favorability][df1.condition2 .== "Assault"])

describe(df1[:post_favorability][df1.condition2 .== "Jokes"])

describe(df1[:post_vote][df1.condition2 .== "Control"])

describe(df1[:post_vote][df1.condition2 .== "Assault"])

describe(df1[:post_vote][df1.condition2 .== "Jokes"])

# t-tests
EqualVarianceTTest(df1[:post_favorability][df1.condition2 .== "Control"],
    df1[:post_favorability][df1.condition2 .== "Assault"])
# shows mean difference of 2.7 (same as on p3 of publication), and p<0.001

EqualVarianceTTest(df1[:post_favorability][df1.condition2 .== "Control"],
    df1[:post_favorability][df1.condition2 .== "Jokes"])

EqualVarianceTTest(df1[:post_favorability][df1.condition2 .== "Jokes"],
    df1[:post_favorability][df1.condition2 .== "Assault"])

EqualVarianceTTest(df1[:post_vote][df1.condition2 .== "Control"],
    df1[:post_vote][df1.condition2 .== "Assault"])
# shows mean difference of 2.2, again matching p3 of publication

EqualVarianceTTest(df1[:post_vote][df1.condition2 .== "Control"],
    df1[:post_vote][df1.condition2 .== "Jokes"])
# this results is a little different from pub (1.4 vs 1.3), but still same general finding

EqualVarianceTTest(df1[:post_vote][df1.condition2 .== "Jokes"],
    df1[:post_vote][df1.condition2 .== "Assault"])

# Figure 1
# note: check again; in model and figure, looks like same party coefs are larger than opposite party ones, yet
# publication report opposite in Fig 1 (p4)
# might just be labelling issue

# using GLM, which calls StatsModels
# GLM syntax is closer to basic R syntax of lm()

# if use StatsModels directly, syntax is:
#m1a = fit(LinearModel, @formula(perchange_favorability ~ condition2), samepartydat)
#m1b = fit(LinearModel, @formula(perchange_favorability ~ condition2), opppartydat)

# using GLM

m1a = lm(@formula(perchange_favorability ~ condition2), samepartydat)
m1b = lm(@formula(perchange_favorability ~ condition2), opppartydat)
m1a

m1b

# no package to plot coefficients (e.g., coefplot in R or Stata) or interactions (e.g., interplot in R)
# but can extract model data and build own
coefdf = DataFrame()
coefdf.name = coefnames(m1a)[2:end] # no intercept
coefdf.nameb = ["Jokes", "Assault"]
coefdf.coef1 = coef(m1a)[2:end]
coefdf.err1 = stderror(m1a)[2:end]
coefdf.upper1 = coefdf.coef1 + 1.96*coefdf.err1
coefdf.lower1 = coefdf.coef1 - 1.96*coefdf.err1
coefdf.coef2 = coef(m1b)[2:end]
coefdf.err2 = stderror(m1b)[2:end]
coefdf.upper2 = coefdf.coef2 + 1.96*coefdf.err2
coefdf.lower2 = coefdf.coef2 - 1.96*coefdf.err2

coefdf

coefdf

function coefplot(m)
       n = coefnames(m)[2:end] # no intercept
       vals = coef(m)[2:end]
       errors = stderror(m)[2:end]
       scatter(
           n,
           vals,
           #seriestype = :scatter,
           #legend = false,
           yerror = 1.96 .* errors,
           title = "Coefficient plot"
       )
end

coefplot(m1a)

# use int from package MLJBase
plot(int(CategoricalArray(coefdf.name), type=Int), coefdf.coef1, seriestype = :scatter, yerror=1.96*coefdf.err1,
    xtickfontsize=18,
    ytickfontsize=18,
    #xshowaxis=false,
    xlabel="condition (Jokes, Assault)",
    xguidefontsize=18,
    ylim = (-40,2),
    ylabel="average treatment effect",
    yguidefontsize=18,
    legendfontsize=18,
    size=(1600,1600),
        legend=false
       )
plot!(int(CategoricalArray(coefdf.name), type=Int).+.15, coefdf.coef2, seriestype = :scatter, yerror=1.96*coefdf.err2, lw=3
       )
hline!([0], seriestype = "hline", lw=2, ls=:dash, lc="black")
annotate!(1.1, -5, "Assault", :black)
annotate!(2.1, -5, "Jokes", :black)

# switch to make horizontal, matching layout in publication
plot(coefdf.coef1, int(CategoricalArray(coefdf.name), type=Int), seriestype = :scatter, xerror=1.96*coefdf.err1,
    markersize=8,
    xtickfontsize=18,
    #ytickfontsize=18,
    #tickfontcolor = false,
    #yshowaxis=false,
    xlabel="average treatment effect",
    xguidefontsize=18,
    xlim = (-40,2),
    ylabel="condition (Jokes, Assault)",
    #yguidefontsize=18,
    label = ("Same party"),
    legendfontsize=18,
    #ytickfontcolor = "white",
    ytickfontsize = 1, # eliminates tick labels
    size=(1600,1600),
    #legend=false,
        legend = :left #:outertopleft
       )
plot!(coefdf.coef2, int(CategoricalArray(coefdf.name), type=Int).+.15, seriestype = :scatter, label = ("Opposite party"), 
            xerror=1.96*coefdf.err2, 
            markersize=8
       )
vline!([0], seriestype = "vline", lw=2, ls=:dash, lc="black", label = false)
annotate!(-5, 1.1, "Assault", :black)
annotate!(-5, 2.1, "Jokes", :black)

savefig("./figures/fig1.png") 

# Figure 2

m2a = lm(@formula(perchange_vote ~ condition2), samepartydat)
m2b = lm(@formula(perchange_vote ~ condition2), opppartydat)
m2a

m2b

coefdf = DataFrame()
coefdf.name = coefnames(m2a)[2:end] # no intercept
coefdf.nameb = ["Jokes", "Assault"]
coefdf.coef1 = coef(m2a)[2:end]
coefdf.err1 = stderror(m2a)[2:end]
coefdf.upper1 = coefdf.coef1 + 1.96*coefdf.err1
coefdf.lower1 = coefdf.coef1 - 1.96*coefdf.err1
coefdf.coef2 = coef(m2b)[2:end]
coefdf.err2 = stderror(m2b)[2:end]
coefdf.upper2 = coefdf.coef2 + 1.96*coefdf.err2
coefdf.lower2 = coefdf.coef2 - 1.96*coefdf.err2

coefdf

plot(coefdf.coef1, int(CategoricalArray(coefdf.name), type=Int), seriestype = :scatter, xerror=1.96*coefdf.err1,
    markersize=8,
    xtickfontsize=18,
    #ytickfontsize=18,
    #tickfontcolor = false,
    #yshowaxis=false,
    xlabel="average treatment effect",
    xguidefontsize=18,
    xlim = (-40,2),
    ylabel="condition (Jokes, Assault)",
    #yguidefontsize=18,
    label = ("Same party"),
    legendfontsize=18,
    #ytickfontcolor = "white",
    ytickfontsize = 1,
    size=(1600,1600),
    #legend=false,
        legend = :left #:outertopleft
       )
plot!(coefdf.coef2, int(CategoricalArray(coefdf.name), type=Int).+.15, seriestype = :scatter, label = ("Opposite party"), 
            xerror=1.96*coefdf.err2, 
            markersize=8
       )
vline!([0], seriestype = "vline", lw=2, ls=:dash, lc="black", label = false)
annotate!(-5, 1.1, "Assault", :black)
annotate!(-5, 2.1, "Jokes", :black)

savefig("./figures/fig2.png") 

# Figure 3

m3a = lm(@formula(perchange_sexism ~ condition2), samepartydat)
m3b = lm(@formula(perchange_sexism ~ condition2), opppartydat)
m3a

m3b

# juts need to change first two lines
m1 = m3a
m2 = m3b
#
coefdf = DataFrame()
coefdf.name = coefnames(m1)[2:end] # no intercept
coefdf.nameb = ["Jokes", "Assault"]
coefdf.coef1 = coef(m1)[2:end]
coefdf.err1 = stderror(m1)[2:end]
coefdf.upper1 = coefdf.coef1 + 1.96*coefdf.err1
coefdf.lower1 = coefdf.coef1 - 1.96*coefdf.err1
coefdf.coef2 = coef(m2)[2:end]
coefdf.err2 = stderror(m2)[2:end]
coefdf.upper2 = coefdf.coef2 + 1.96*coefdf.err2
coefdf.lower2 = coefdf.coef2 - 1.96*coefdf.err2

coefdf

plot(coefdf.coef1, int(CategoricalArray(coefdf.name), type=Int), seriestype = :scatter, xerror=1.96*coefdf.err1,
    markersize=8,
    xtickfontsize=18,
    #ytickfontsize=18,
    #tickfontcolor = false,
    #yshowaxis=false,
    xlabel="average treatment effect",
    xguidefontsize=18,
    xlim = (-5,5),
    ylabel="condition (Jokes, Assault)",
    yguidefontsize=18,
    label = ("Same party"),
    legendfontsize=18,
    #ytickfontcolor = "white",
    ytickfontsize = 1,
    size=(1600,1600),
    #legend=false,
        legend = :left #:outertopleft
       )
plot!(coefdf.coef2, int(CategoricalArray(coefdf.name), type=Int).+.15, seriestype = :scatter, label = ("Opposite party"), 
            xerror=1.96*coefdf.err2, 
            markersize=8
       )
vline!([0], seriestype = "vline", lw=2, ls=:dash, lc="black", label = false)
annotate!(4, 1.1, "Assault", :black)
annotate!(4, 2.1, "Jokes", :black)

savefig("./figures/fig3.png") 

# Figure 4

sametempdf1 = samepartydat[(samepartydat[:condition2] .== "Assault"),:]
sametempdf2 = samepartydat[(samepartydat[:condition2] .== "Jokes"),:]


opptempdf1 = opppartydat[(opppartydat[:condition2] .== "Assault"),:]
opptempdf2 = opppartydat[(opppartydat[:condition2] .== "Jokes"),:]

sametempdf1[:mean] = mean(sametempdf1.meanpunishment)
sametempdf1[:err] = std(sametempdf1.meanpunishment)
sametempdf2[:mean] = mean(sametempdf2.meanpunishment)
sametempdf2[:err] = std(sametempdf2.meanpunishment)

opptempdf1[:mean] = mean(opptempdf1.meanpunishment)
opptempdf1[:err] = std(opptempdf1.meanpunishment)
opptempdf2[:mean] = mean(opptempdf2.meanpunishment)
opptempdf2[:err] = std(opptempdf2.meanpunishment)

tempdf1 = DataFrame()
tempdf1[:mean] = [sametempdf1.mean[1], sametempdf2.mean[1]]
tempdf1.condition2 = ["Assault", "Jokes"]
tempdf1.err = [sametempdf1.err[1], sametempdf2.err[1]]
tempdf1

tempdf2 = DataFrame()
tempdf2[:mean] = [opptempdf1.mean[1], opptempdf2.mean[1]]
tempdf2.condition2 = ["Assault", "Jokes"]
tempdf2.err = [opptempdf1.err[1], opptempdf2.err[1]]
tempdf2

g1 = plot(int(CategoricalArray(tempdf1.condition2), type=Int), tempdf1.mean, seriestype = :scatter, yerror=1.44*tempdf1.err,
        markersize=8,
    ytickfontsize=18,
    #ytickfontsize=18,
    #tickfontcolor = false,
    #yshowaxis=false,
    ylabel="mean punitiveness",
    yguidefontsize=18,
    ylim = (1,5),
    xlabel="condition (Jokes, Assault)",
    #xguidefontsize=18,
    label = ("Same party"),
    legendfontsize=18,
    #ytickfontcolor = "white",
    xtickfontsize = 1,
    size=(1600,1600),
    legend=false
    #legend = :left #:outertopleft,
    )
hline!([0], seriestype = "vline", lw=2, ls=:dash, lc="black", label = false)
#annotate!(4, 1.1, "Assault", :black)
g2 = plot(int(CategoricalArray(tempdf2.condition2), type=Int), tempdf2.mean, seriestype = :scatter, yerror=1.44*tempdf2.err,
         markersize=8,
    ytickfontsize=18,
    #ytickfontsize=18,
    #tickfontcolor = false,
    #yshowaxis=false,
    ylabel="mean punitiveness",
    yguidefontsize=18,
    ylim = (1,5),
    xlabel="condition (Jokes, Assault)",
    #xguidefontsize=18,
    label = ("Same party"),
    legendfontsize=18,
    #ytickfontcolor = "white",
    xtickfontsize = 1,
    size=(1600,1600),
    legend=false
    #    legend = :left #:outertopleft
    )
hline!([0], seriestype = "vline", lw=2, ls=:dash, lc="black", label = false)
#annotate!(4, 1.1, "Assault", :black)
plot(g1, g2)

# l = @layout [a ; b c]
        

savefig("./figures/fig4.png") 

#using JLD2
@save "./data/working/working.jld" df1

# use julia's plotting logic to plot two graphs side by side

# Figure 5
# using GLM

m5  = lm(@formula(perchange_favorability ~ condition2 + pre_sexism + condition2*pre_sexism), df1)
m5

# desccribe(df1.pre_sexism)
# pre_sexism ranges from 1-5 and increases in small increments
# so draw random sample of 500 obs from uniform distribution between 1-5, with precision 0.001
MVZ = rand((1: 0.001 :5),500) # make sure 0 appears before decimal, otherwise decimal is broadcasting syntax in julia
MVZ = sort(MVZ)
plot(MVZ)

# put the in dataframe and add other vars
intdf = DataFrame()
intdf[:MVZ] = MVZ
intdf[:b1] = coef(m5)[2]
intdf[:b2] = coef(m5)[3]
intdf[:b4] = coef(m5)[5]
intdf[:b5] = coef(m5)[6]
# model matrix is:
mm = modelmatrix(ModelFrame(@formula(perchange_favorability ~ condition2 + pre_sexism + condition2*pre_sexism), df1))
# modelmatrix (lowercase) is from pkg StatsModels
# could also use ModelMatrix from pkg DataFrames, but them matrix is indexed within object mm
# to get model matrix, need to call mm.m
# to see object properties, use propertynames(mm)
#var-cov matrix is:
varcovm5 = vcov(m5)
# if used ModelMatrix instead of modelmatrix, change this to:
# vcov(mm.m)
# notice that cov() from Statistics package does not return same thing as vcov from StatsModels pkg
#varcovm5
intdf[:varb1] = varcovm5[2,2]
intdf[:varb2] = varcovm5[3,3]
intdf[:varb4] = varcovm5[5,5]
intdf[:varb5] = varcovm5[6,6]
intdf[:covb1b4] =  varcovm5[2,5]
intdf[:covb2b5] =  varcovm5[3,6]
intdf

# conditional effect for condition=jokes
intdf[:conbx1]=intdf.b1+(intdf.b4 .* intdf.MVZ) # remember decimal ahead of * for element-wise operation on array
intdf[:consx1]=(intdf.varb1 + (intdf.varb4.*(intdf.MVZ.^2)) + (2 .* intdf.covb1b4 .* intdf.MVZ)).^(.5) # 
intdf[:err1]=1.96*intdf.consx1
intdf[:upperx1]=intdf.conbx1+intdf.err1
intdf[:lowerx1]=intdf.conbx1-intdf.err1 # 

# conditional effect for condition=assasult
intdf[:conbx2]=intdf.b2+(intdf.b5 .* intdf.MVZ)
intdf[:consx2]=(intdf.varb2 +(intdf.varb5.*(intdf.MVZ.^2)) + (2 .*intdf.covb2b5.*intdf.MVZ)).^(.5) # 
intdf[:err2]=1.96*intdf.consx2
intdf[:upperx2]=intdf.conbx2+intdf.err2
intdf[:lowerx2]=intdf.conbx2-intdf.err2 # 
intdf[1:10, [14,19]]

# error should show U-shaped curve
plot(intdf.MVZ, intdf.err1, size=(1600,1600), ytickfontsize=18, xtickfontsize=18)

# jokes
g1 = plot(intdf.MVZ, intdf.conbx1, ribbon = (intdf.conbx1 .- intdf.lowerx1, intdf.upperx1 - intdf.conbx1),
    lc="black",
    lw=2,
    c=:grey,
    fillalpha = 0.2,
        #markersize=8,
    ytickfontsize=18,
    #ytickfontsize=18,
    #tickfontcolor = false,
    #yshowaxis=false,
    ylabel="conditional effect of Tx (Jokes)",
    yguidefontsize=18,
    ylim = (-60,10),
    xlabel="pre_sexism",
    xguidefontsize=18,
    #label = ("jokes"),
    #legendfontsize=18,
    #ytickfontcolor = "white",
    xtickfontsize = 18,
    title = "Jokes",
    size=(1600,1600),
    legend=false
    #legend = :left #:outertopleft,
    )
hline!([0], seriestype = "hline", lw=2, ls=:dash, lc="black", label = false)
#annotate!(4, 1.1, "Assault", :black)

# assault
g2 = plot(intdf.MVZ, intdf.conbx2, ribbon = (intdf.conbx2 .- intdf.lowerx2, intdf.upperx2 - intdf.conbx2), 
    lc="black",
    lw=2,
    c=:grey,
    fillalpha = 0.2,
        #markersize=8,
    ytickfontsize=18,
    #ytickfontsize=18,
    #tickfontcolor = false,
    #yshowaxis=false,
    ylabel="conditional effect of Tx (Assault)",
    yguidefontsize=18,
    ylim = (-60,10),
    xlabel="pre_sexism",
    xguidefontsize=18,
    #label = ("jokes"),
    #legendfontsize=18,
    xtickfontsize = 18,
    title = "Assault",
    size=(1600,1600),
    legend=false
    #legend = :left #:outertopleft,
    )
hline!([0], seriestype = "hline", lw=2, ls=:dash, lc="black", label = false)
#annotate!(4, 1.1, "Assault", :black)

plot(g2, g1)

savefig("./figures/fig5.png") 

# Figure 6
m6  = lm(@formula(perchange_vote ~ condition2 + pre_sexism + condition2*pre_sexism), df1)
m6

# use MVZ from before and put the in dataframe and add other vars
intdf = DataFrame()
intdf[:MVZ] = MVZ
intdf[:b1] = coef(m6)[2]
intdf[:b2] = coef(m6)[3]
intdf[:b4] = coef(m6)[5]
intdf[:b5] = coef(m6)[6]
# model matrix is:
mm = modelmatrix(ModelFrame(@formula(perchange_favorability ~ condition2 + pre_sexism + condition2*pre_sexism), df1))
# modelmatrix (lowercase) is from pkg StatsModels
# could also use ModelMatrix from pkg DataFrames, but them matrix is indexed within object mm
# to get model matrix, need to call mm.m
# to see object properties, use propertynames(mm)
#var-cov matrix is:
varcovm6 = vcov(m6)
# if used ModelMatrix instead of modelmatrix, change this to:
# vcov(mm.m)
# notice that cov() from Statistics package does not return same thing as vcov from StatsModels pkg
#varcovm5
intdf[:varb1] = varcovm6[2,2]
intdf[:varb2] = varcovm6[3,3]
intdf[:varb4] = varcovm6[5,5]
intdf[:varb5] = varcovm6[6,6]
intdf[:covb1b4] =  varcovm6[2,5]
intdf[:covb2b5] =  varcovm6[3,6]
intdf

#
# conditional effect for condition=jokes
intdf[:conbx1]=intdf.b1+(intdf.b4 .* intdf.MVZ) # remember decimal ahead of * for element-wise operation on array
intdf[:consx1]=(intdf.varb1 + (intdf.varb4.*(intdf.MVZ.^2)) + (2 .* intdf.covb1b4 .* intdf.MVZ)).^(.5) # 
intdf[:err1]=1.96*intdf.consx1
intdf[:upperx1]=intdf.conbx1+intdf.err1
intdf[:lowerx1]=intdf.conbx1-intdf.err1 # 

# conditional effect for condition=assasult
intdf[:conbx2]=intdf.b2+(intdf.b5 .* intdf.MVZ)
intdf[:consx2]=(intdf.varb2 +(intdf.varb5.*(intdf.MVZ.^2)) + (2 .*intdf.covb2b5.*intdf.MVZ)).^(.5) # 
intdf[:err2]=1.96*intdf.consx2
intdf[:upperx2]=intdf.conbx2+intdf.err2
intdf[:lowerx2]=intdf.conbx2-intdf.err2 # 
intdf[1:10, [14,19]]

# error should show U-shaped curve
plot(intdf.MVZ, intdf.err1, size=(1600,1600), ytickfontsize=18, xtickfontsize=18)

# jokes
g1 = plot(intdf.MVZ, intdf.conbx1, ribbon = (intdf.conbx1 - intdf.lowerx1, intdf.upperx1 - intdf.conbx1),
    lc="black",
    lw=2,
    c=:grey,
    fillalpha = 0.2,
        #markersize=8,
    ytickfontsize=18,
    #ytickfontsize=18,
    #tickfontcolor = false,
    #yshowaxis=false,
    ylabel="conditional effect of Tx (Jokes)",
    yguidefontsize=18,
    ylim = (-60,10),
    xlabel="pre_sexism",
    xguidefontsize=18,
    #label = ("jokes"),
    #legendfontsize=18,
    #ytickfontcolor = "white",
    xtickfontsize = 18,
    title = "Jokes",
    size=(1600,1600),
    legend=false
    #legend = :left #:outertopleft,
    )
hline!([0], seriestype = "hline", lw=2, ls=:dash, lc="black", label = false)
#annotate!(4, 1.1, "Assault", :black)

# assault
g2 = plot(intdf.MVZ, intdf.conbx2, ribbon = (intdf.conbx2 - intdf.lowerx2, intdf.upperx2 - intdf.conbx2), 
    lc="black",
    lw=2,
    c=:grey,
    fillalpha = 0.2,
        #markersize=8,
    ytickfontsize=18,
    #ytickfontsize=18,
    #tickfontcolor = false,
    #yshowaxis=false,
    ylabel="conditional effect of Tx (Assault)",
    yguidefontsize=18,
    ylim = (-60,10),
    xlabel="pre_sexism",
    xguidefontsize=18,
    #label = ("jokes"),
    #legendfontsize=18,
    xtickfontsize = 18,
    title = "Assault",
    size=(1600,1600),
    legend=false
    #legend = :left #:outertopleft,
    )
hline!([0], seriestype = "hline", lw=2, ls=:dash, lc="black", label = false)
#annotate!(4, 1.1, "Assault", :black)

plot(g2,g1)

savefig("./figures/fig6.png") 

# Figure 7

m7  = lm(@formula(meanpunishment ~ 1 + pre_sexism), df1)
m7

GLM.predict(m7)

temp = DataFrame()
temp.pre_sexism = rand(1 : 0.01 : 5, 1870)
temp
#temp = convert(NamedArray, temp)


histogram(temp.pre_sexism)

pred = GLM.predict(m7, temp, interval = :confidence)

pred.x = temp.pre_sexism
pred

# sort by x-value before plotting
# otherwise, ribbon does not plot well
sort!(pred, [:x])

plot(pred.x, pred.prediction,
    ribbon = (pred.prediction .- pred.lower, pred.upper .- pred.prediction), 
    #fillrange = [pred.prediction - pred.err pred.prediction + pred.err],
    lc="black",
    lw=2,
    c=:grey,
    fillalpha = 0.3,
        #markersize=8,
    ytickfontsize=18,
    #ytickfontsize=18,
    #tickfontcolor = false,
    #yshowaxis=false,
    ylabel="mean punitiveness (1-5)",
    yguidefontsize=18,
    #ylim = (1.8,3.8),
    xlabel="pre_sexism (1-5)",
    xguidefontsize=18,
    #label = ("jokes"),
    #legendfontsize=18,
    xtickfontsize = 18,
    title = "Effect of sexism on punitiveness",
    size=(1600,1600),
    legend=false
    #legend = :left #:outertopleft,
    )

savefig("./figures/fig7.png") 
