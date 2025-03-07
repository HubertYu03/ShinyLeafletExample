library(RNetCDF)

options(max.print = 999999)

data <- open.nc("snow_out50_test.nc", write = FALSE)

file.inq.nc(data)["format"]

print.nc(data)

# snow_data <- var.get.nc(data, "gsl")
# print(snow_data)
