# Read and validate injury data from a CSV file

Reads a CSV file (e.g. one created with
[`create_injury_template()`](https://thomas-fung.github.io/spinviz/reference/create_injury_template.md)
and filled in) and checks that it has the structure
[`injury_heatmap()`](https://thomas-fung.github.io/spinviz/reference/injury_heatmap.md)
expects: `Region.area` and `Subcategory` columns plus at least one sport
column of injury frequencies.

## Usage

``` r
read_injury_data(path)
```

## Arguments

- path:

  File path of the CSV to read.

## Value

A data frame with `Region.area`, `Subcategory`, and one column per sport
(coerced to numeric).

## See also

[`create_injury_template()`](https://thomas-fung.github.io/spinviz/reference/create_injury_template.md)
to generate a correctly formatted file.

## Examples

``` r
path <- tempfile(fileext = ".csv")
create_injury_template(path, sports = "boxing")
read_injury_data(path)
#>    Region.area    Subcategory boxing
#> 1         <NA>           Head     NA
#> 2         <NA>           Neck     NA
#> 3         <NA>       Shoulder     NA
#> 4         <NA>          Chest     NA
#> 5         <NA>      Upper Arm     NA
#> 6         <NA>          Elbow     NA
#> 7         <NA>        Abdomen     NA
#> 8         <NA>        Forearm     NA
#> 9         <NA>      Hip Groin     NA
#> 10        <NA>          Wrist     NA
#> 11        <NA>           Hand     NA
#> 12        <NA>          Thigh     NA
#> 13        <NA>           Knee     NA
#> 14        <NA>      Lower Leg     NA
#> 15        <NA>          Ankle     NA
#> 16        <NA>           Foot     NA
#> 17        <NA> Thoracic Spine     NA
#> 18        <NA>    Lumbosacral     NA
```
