**Help With Covid**

# URL
```
http://localhost:3000/
```
# API
```
http:///localhost:3000/api/v1/
```

## Medical (Diseases, Cases, ...)
```
http:///localhost:3000/api/v1/medical/
```
* Diseases (currently `COVID-19`)
http://localhost:3000/api/v1/medical/diseases

* Cases by total
http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/total

* Cases by timeline
http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline

* Filter data by:
* * Continent: http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline?continent_id=AS
* * Country: http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline?country_id=US
* * Level-1: http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline?country_id=US&level1_id=DC
* * Date (Range): http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline?from=2020-01-01&to=2020-02-01
* * Type (Sure, Dead, Heal): http://localhost:3000/api/v1/medical/diseases/COVID-19/cases/timeline?type=sure

#### Sources:
- COVID-19: 
- - JHU CSSE: https://github.com/CSSEGISandData/COVID-19

### Geographic (Continents, Countries, ...)

* Continents
http://localhost:3000/api/v1/geo/continents

* * Countries
http://localhost:3000/api/v1/geo/continents/AS/countries

* Countries
http://localhost:3000/api/v1/geo/countries

* * Levels
http://localhost:3000/api/v1/geo/countries/YE/division/levels

* * Level-1
http://localhost:3000/api/v1/geo/countries/YE/division/level1

#### Sources:
* GeoNames: http://www.geonames.org/data-sources.html