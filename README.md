# Help With Covid API

## Deployment (`development`)
1. unzip `vendor/data.zip`
2. run `rails db:reset; rails db:migrate; rails db:seed;`

## API
```
http://localhost:3000/api/v1/
```

## Modules
### Medical (Diseases, Cases, ...)
```
http://localhost:3000/api/v1/medical/
```
* Diseases (currently *COVID-19*):
http://localhost:3000/api/v1/medical/diseases

* Cases *by total*:
http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/total

* Cases *by timeline*:
http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline

* Filter data by:
* * Continent: http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline?continent_id=AS
* * Country: http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline?country_id=US
* * Level-1: http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline?country_id=US&level1_id=DC
* * Date (*range)*: http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline?from=2020-01-01&to=2020-02-01
* * Type (*heal*, *sure*, *dead*): http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline?type=heal

#### Sources:
- COVID-19 *(Auto collect via `Medical::Disease::Case::FetchJob`)*: 
- - JHU CSSE: https://github.com/CSSEGISandData/COVID-19

### Geographic (Continents, Countries, ...)
```
http://localhost:3000/api/v1/geo/
```

* Continents:
```
http://localhost:3000/api/v1/geo/continents
```

* * Countries *by continent*:
http://localhost:3000/api/v1/geo/continents/AS/countries

* Countries:
http://localhost:3000/api/v1/geo/countries

* * Levels:
http://localhost:3000/api/v1/geo/countries/YE/division/levels

* * Level-1:
http://localhost:3000/api/v1/geo/countries/YE/division/level1

#### Sources:
* GeoNames: http://www.geonames.org/data-sources.html