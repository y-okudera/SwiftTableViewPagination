# SwiftTableViewPagination
Swift TableView pagination with async API request.

## Output UML

Create puml file.

```
$ cd SwiftTableViewPagination/scripts/swiftuml

# DataSource
$ find ../../SwiftTableViewPagination/DataSource | grep .swift | xargs -L 1 sh plantuml.sh | grep -v @enduml | grep -v @startuml >> output_`date '+%Y%m%d%H%M%S'`.puml

# Presentation
$ find ../../SwiftTableViewPagination/Presentation | grep .swift | xargs -L 1 sh plantuml.sh | grep -v @enduml | grep -v @startuml >> output_`date '+%Y%m%d%H%M%S'`.puml
```

puml to png via Visual Studio Code.

shift + cmd + p

```
> PlantUML: Export Current File Diagrams
```

### DataSource
![DataSource](https://user-images.githubusercontent.com/25205138/146673160-8836038d-f7d6-4c55-81ab-b838e9dc7fae.png)

### Presentation 
![Presentation](https://user-images.githubusercontent.com/25205138/146673175-0141fb17-3be5-42b0-9b14-e18d63e0db40.png)
