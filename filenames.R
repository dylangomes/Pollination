setwd("E:/Phantom_Rivers/Flower_photos/")
setwd("C:/Flower_photos")
dir()

Rename<-function(names){
mtime <- file.mtime(names)

DateTime <- paste(paste0(
  substr(mtime,1,4),
  substr(mtime,6,7),
  substr(mtime,9,10)),
  paste0(substr(mtime,12,13),
         substr(mtime,15,16),
         substr(mtime,18,19)),
  sep = "_")


file.rename(names, paste0(substr(names,0,4),"/",paste(substr(names,0,4),DateTime,sep="_"),".jpg") )
}

Renamer <- function(){
  names<-list.files(pattern="^IMG",recursive = T)
  lapply(names, Rename)
}


Renamer()
beep()
