#scientific notation
2/10000

#x=1
x<-1
#remove x
rm(x)

#six comparison functions
mynumber <-6
#question (two equal signs) = R does mynumer equals 5?
mynumber==5

#questions = R does mynumber different than 5?
mynumber!=5

#others
mynumber <3

mynumber<= -1

#errors and warnings
log("a_word")
#nao_pode_colocar algo nao numerico dentro da funçao log

#NaN é o mesmo que "not a number"

#challenge
elephant1_kg<-3492
elephant2_lb<-7757
elephant1_lb<-elephant1_kg *2.2

myelephants<-c(elephant1_lb, elephant2_lb)
hich(myelephants == max(myelephant2_lb))

d<-read.csv("./data/tail_lenght.csv")
dir.create("./lectures")




# How are thinks about data


##Vectors
weight_g<-c(50,60,65,82)
animals<-c("mouse", "rat","dog")
animals


lenght(weight_g)
str(weight_g)


num_char <- c(1,2,3,"a")
num_char
class(1,2,3,"a")
num_logical<-c(1,2,3, TRUE)
num_logical
char_logical<-c("a","b","c",TRUE)
char_logical
class(num_char)
class(num_logical)
class(char_logical)
