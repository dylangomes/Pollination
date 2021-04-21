library(beepr)

setwd("C:/")
setwd("E:/")

names<-dir(recursive = T, full.names=T)
head(names)
names<-names[which(substr(names,4,10)!="RECYCLE")] # remove recycling bin


out<-strsplit(names, "/")
test<-data.frame(do.call(rbind,out))
cols=names(test)
test[cols]<-lapply(test[cols], as.character)
test$X4<-ifelse(test$X4==".",test$X3,test$X4)

test$X3[which(test$X3==test$X4)]<-NA
test<-test[,-1]

test<-test[test$X2!="System Volume Information",]
names(test)<-c("Site","Location","File")

test$Location<-gsub(" ","",test$Location)
datetime<-data.frame(do.call(rbind,strsplit(test$File,"_")))

sheet<-cbind(test,datetime[,c(2,3)])
cols=names(sheet)
sheet[cols]<-lapply(sheet[cols], as.character)
sheet$X3<-substr(sheet$X3,0,nchar(sheet$X3)-6)
names(sheet)[4:5]<-c("Date","Time")

sheet$`#Flowers`<-""
sheet$Present<-""
sheet$Insect<-""
head(sheet)


writeEach<-function(site){
write.csv(sheet[sheet$Site==site,], file=paste0(site, "/datasheet.csv"), row.names=F)
}

lapply(unique(sheet$Site),writeEach)
