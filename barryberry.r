library("png", lib.loc="/Users/meyer48/Downloads/")
setwd("/Users/meyer48/Documents/R/BarryBerry/sources")
sourceImagesfp<-list.files(full.name=TRUE)
print(sourceImagesfp)
berry1<-readPNG(sourceImagesfp[1])

sourceImages<-list()
length(sourceImages)<-length(sourceImagesfp)
sourceAverages<-list()
length(sourceAverages)<-length(sourceImagesfp)

colorDistance <- function(color1, color2)
{
    return(sqrt((0.3*(color1[1]-color2[1]))^2 + (0.6*(color1[2]-color2[2]))^2 + (0.1*(color1[3]-color2[3]))^2))
}


print(sourceImagesfp)
sourceImageCounter<-1
for (fpberry in sourceImagesfp)
{
    berryImg<-readPNG(fpberry)
    sourceImages[[sourceImageCounter]]<-berryImg
    
    testColr<-weighted.mean(berryImg[,,1], berryImg[,,4])
    testColg<-weighted.mean(berryImg[,,2], berryImg[,,4])
    testColb<-weighted.mean(berryImg[,,3], berryImg[,,4])
    testCol<-c(testColr,testColg,testColb)
    sourceAverages[[sourceImageCounter]]<-testCol
    
    sourceImageCounter<-sourceImageCounter+1
}

setwd("/Users/meyer48/Documents/R/BarryBerry/target")
targetImagefp<-list.files(full.name=TRUE)[1]
targetImage<-readPNG(targetImagefp)
png("../test.png", width=dim(targetImage)[2], height=dim(targetImage)[1], bg="transparent")
plot(c(0, dim(targetImage)[2]), c(0, dim(targetImage)[1]), type = "n", xlab = "", ylab = "")

print(dim(targetImage))

yprev<-1
ystep<-10
yimg<-25
yiter<-seq(ystep, dim(targetImage)[1], ystep)

xprev<-1
xstep<-10
ximg<-25
xiter<-seq(xstep, dim(targetImage)[2], xstep)

for (y in sample(yiter, length(yiter), replace=FALSE, prob=NULL))
{
    print(y)
    yprev<- y - ystep + 1
    for (x in sample(xiter, length(xiter), replace=FALSE, prob=NULL))
    {
        xprev<- x - xstep + 1
        yrange<-yprev:min(yprev+yimg,dim(targetImage)[1])
        xrange<-xprev:min(xprev+ximg,dim(targetImage)[2])
        targetColr<-mean(targetImage[yrange,xrange,1])
        targetColg<-mean(targetImage[yrange,xrange,2])
        targetColb<-mean(targetImage[yrange,xrange,3])
        targetCol<-c(targetColr,targetColg,targetColb)
        
        
        closestColor<-0
        closestColorDist<-9999999
        setwd("/Users/meyer48/Documents/R/BarryBerry/sources")
        
        for (sourceImageCounter in seq(1, length(sourceImagesfp), 1))
        {
            
            if (closestColorDist > colorDistance(targetCol, sourceAverages[[sourceImageCounter]]))
            {
                closestColor<-sourceImages[[sourceImageCounter]]
                closestColorDist<-colorDistance(targetCol, sourceAverages[[sourceImageCounter]])
            }
        }
        rasterImage(closestColor, dim(targetImage)[2]-xprev,dim(targetImage)[1]-yprev,dim(targetImage)[2]-(xprev+ximg),dim(targetImage)[1]-(yprev+yimg))
    }
}
dev.off()