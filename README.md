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
![DataSource](https://user-images.githubusercontent.com/25205138/146682191-bc533dcf-ea72-42b2-8eeb-f696df063270.png)

### Presentation 
![Presentation](https://user-images.githubusercontent.com/25205138/146682187-b39fb04a-fc83-4be3-bcb8-da4a3e001af7.png)
