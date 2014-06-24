library("png", lib.loc="/Users/meyer48/Downloads/")
setwd("/Users/meyer48/Documents/R/BarryBerry/sources")
sourceImages<-list.files(full.name=TRUE)
berry1<-readPNG(sourceImages[1])

yprev<-1
ystep<-10
xprev<-1
xstep<-10
for (fpberry in sourceImages)
{
    berryImg<-readPNG(fpberry)
    scaleBerryImg
    
    print(paste("File: ", fpberry))
    print(mean(berry1))
    print(mean(berry1[,,1]))
    print(weighted.mean(berry1[,,1], berry1[,,4]))
    print(mean(berry1[,,2]))
    print(weighted.mean(berry1[,,2], berry1[,,4]))
    print(mean(berry1[,,3]))
    print(weighted.mean(berry1[,,3], berry1[,,4]))
    print("")
}

setwd("/Users/meyer48/Documents/R/BarryBerry/target")
targetImage<-list.files(full.name=TRUE)[1]
newImage<-array(0, prod(dim(targetImage)))
newImage.dim<-dim(targetImage)

for (y in seq(yprev+ystep, dim(targetImage)[1], ystep))
{
    for (x in seq(xprev+xstep, dim(targetImage)[2], xstep))
    {
        weighted.mean()
    }
}