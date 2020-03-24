**MochaCDN** is a mixed, rapid, global content delivery network.

# DATA

## URL
```
data.mochacdn.com
```

### Medical (Diseases, Cases, ...)

* Diseases
https://data.mochacdn.com/api/v1/medical/diseases

* Cases by total
https://data.mochacdn.com/api/v1/medical/diseases/COVID-19/cases/total

* Cases by timeline
https://data.mochacdn.com/api/v1/medical/diseases/COVID-19/cases/timeline

* Parameters:
* * Continent: https://data.mochacdn.com/api/v1/medical/diseases/COVID-19/cases/timeline?continent_id=AS
* * Country: https://data.mochacdn.com/api/v1/medical/diseases/COVID-19/cases/timeline?country_id=US
* * Level-1: https://data.mochacdn.com/api/v1/medical/diseases/COVID-19/cases/timeline?country_id=US&level1_id=DC
* * Date: https://data.mochacdn.com/api/v1/medical/diseases/COVID-19/cases/timeline?from=2020-01-01&to=2020-02-01
* * Type (sure, dead, heal): https://data.mochacdn.com/api/v1/medical/diseases/COVID-19/cases/timeline?type=sure

#### Sources:
- COVID-19: 
- - JHU CSSE: https://github.com/CSSEGISandData/COVID-19

### Geographic (Continents, Countries, ...)

* Continents
https://data.mochacdn.com/api/v1/geo/continents

* * Countries
https://data.mochacdn.com/api/v1/geo/continents/AS/countries

* Countries
https://data.mochacdn.com/api/v1/geo/countries

* * Levels
https://data.mochacdn.com/api/v1/geo/countries/YE/division/levels

* * Level-1
https://data.mochacdn.com/api/v1/geo/countries/YE/division/level1

#### Sources:
* GeoNames: http://www.geonames.org/data-sources.html

---

## AJAX
```
ajax.mochacdn.com
```

## Parameters

### Mix (JS, CSS)
List of packages to mix

```
/(js|css)?mix=package1,package2,package3
```

You can also use above pattern:
```
/(js|css)?mix=package1@1.0.0,package2/path/to/file,package3
```
- We'll do our best to find main file.
- No need to use file extention (.js|.css).

---

### Env (Enviroment)
#### Production: (`default`)
- Minify: true
```
&env=production
```
#### Development:
- Minify: false
```
&env=development
```

## Usage

### NPM
#### Pattern:
```
/npm/package@version/path/to/file
```
#### Examples:
- Normal:
https://ajax.mochacdn.com/npm/jquery/dist/jquery.js

- Mix Javascript:
https://ajax.mochacdn.com/npm/js?mix=bootstrap,aos
- Mix Stylesheet:
https://ajax.mochacdn.com/npm/css?mix=bootstrap,aos

#### Sources:
* NPM Registry: https://docs.npmjs.com/using-npm/registry.html