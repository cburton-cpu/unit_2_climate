# CCB
# 2026-01-27
# Unit 2: Climate

# read in data

ant_ice_loss = read.table(file = "data/antarctica_mass_200204_202505.txt", 
                          skip=31,
                        header = F,
                      col.names = c("decimal_date", "mass_in_Gt", "sigma_in_Gt"))
ant_ice_loss
head(ant_ice_loss)

grn_ice_loss = read.table(file = "data/greenland_mass_200204_202505.txt", 
                          skip=31,
                        header = F,
                      col.names = c("decimal_date", "mass_in_Gt", "sigma_in_Gt"))
head(grn_ice_loss)
dim(ant_ice_loss)
summary(grn_ice_loss)

# plot data

range(grn_ice_loss$mass_in_Gt)

plot(x= ant_ice_loss$decimal_date, y=ant_ice_loss$mass_in_Gt,
    type="l",
  xlab="",
ylab="Antartic Mass Loss (Gt)")

plot(mass_in_Gt ~ decimal_date,
  data = grn_ice_loss,
    type="l",
  xlab="",
ylab="Greenland Mass Loss (Gt)")

## plotting both on one graph 

plot(x= ant_ice_loss$decimal_date, y=ant_ice_loss$mass_in_Gt,
    type="l",
    ylim= range(grn_ice_loss$mass_in_Gt),
  xlab="",
ylab="Antartic Mass Loss (Gt)")

lines(mass_in_Gt ~ decimal_date,
  data = grn_ice_loss,
    type="l",
    col="red",
    xlab="",
ylab="Ice Mass Loss (Gt)")

# add a break between ice break

data_break = data.frame(decimal_date = 2018,
                          mass_in_Gt = NA,
                        sigma_in_Gt = NA)
data_break
ant_ice_loss_NA = rbind(ant_ice_loss, data_break)
head(ant_ice_loss_NA)
tail(ant_ice_loss_NA)


order(ant_ice_loss_NA$decimal_date) #orders the row numbers by the data in the row (in this case the decimal date)

#it worked! break was added to Ant. data
ant_ice_loss_NA = ant_ice_loss_NA[order(ant_ice_loss_NA$decimal_date), ]
tail(ant_ice_loss_NA)
#do it to greenland
grn_ice_loss_NA = rbind(grn_ice_loss, data_break)
grn_ice_loss_NA = grn_ice_loss_NA[order(grn_ice_loss_NA$decimal_date), ]
tail(ant_ice_loss_NA)

#even with changes nothing happened (we want a breakkkkk)
plot(x= ant_ice_loss_NA$decimal_date, y=ant_ice_loss_NA$mass_in_Gt,
    type="l",
    ylim= range(grn_ice_loss$mass_in_Gt),
  xlab="",
ylab="Antartic Mass Loss (Gt)")
lines(((sigma_in_Gt * 2) + mass_in_Gt) ~ decimal_date,
                            data = ant_ice_loss_NA,
                          lty = "dashed")
lines((mass_in_Gt - (sigma_in_Gt *2)) ~ decimal_date,
                            data = ant_ice_loss_NA,
                          lty = "dashed")
lines(mass_in_Gt ~ decimal_date,
  data = grn_ice_loss_NA,
    type="l",
    col="red",
    xlab="",
ylab="Ice Mass Loss (Gt)")
#lty = is the command for line type

min(ant_ice_loss$mass_in_Gt)
min(grn_ice_loss$mass_in_Gt)

#open up a plotting device
pdf("figures/ice_mass_trends.pdf", width = 7, height = 5)

#create the figure
barplot(height = c(min(ant_ice_loss$mass_in_Gt), min(grn_ice_loss$mass_in_Gt)) *(-1),
  names.arg = c("Antartica", "Greenland"))

#close the plotting device
dev.off()