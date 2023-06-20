# Un framework multi-linguaggio per l'identificazione delle dipendenze del codice sorgente

## A language-agnostic framework to build source code dependency graph

## Tesi del corso di Laurea in Informatica, anno 2022/2023

## Abstract

Nell'Ingegneria del Software e' importante avere a disposizione tool automatici che permettano di controllare le violazioni delle politiche nel codice, tuttavia essi richiedono di analizzare relazioni e dipendenze dei componenti di una code base di grandi dimensioni e che puo' essere scritta con vari linguaggi di programmazione. La maggior parte dei tool presenti nel mercato del software proprietario o libero fanno uso di ulteriori software di terze parti per ottenere il grafo delle dipendenze di un certo progetto e questa operazione, oltre ad essere molto onerosa quando si decida di appoggiarsi a Language Server o moduli simili, richiede di usare un software diverso per ogni linguaggio di programmazione da analizzare. Lo scopo di questa ricerca e' verificare sotto quali condizioni si possa rimuovere la language dependency della costruzione del grafo delle dipendenze usano due librerie: Tree Sitter e Stack Graph. Dopo avere analizzato le due tecnologie proposte, il modello introdotto ad hoc e la sua implementazione, vengono valutate l'efficacia e l'accuratezza di questa soluzione.

## Scaletta Programmatica

- [x] Introduzione
    - [x] Caso di studio - Arcan
      - [x] Architectural Smell e Dipendenze
      - [x] Tool Arcan
      - [x] Limitazioni Tecniche
    - [x] La soluzione proposta
      - [x] Alcune librerie utili
        - [x] Rust
        - [x] Tree Sitter
        - [x] Stack Graph
        - [x] Tree Sitter Stack Graph
      - [x] L'approccio
        - [x] Stack Graph in azione
        - [x] Valuzione dei risultati
    - [x] Sommario dei Capitoli
- [x] Tree Sitter
    - [x] Introduzione
    - [x] Esempio
    - [x] In Rust
    - [x] Il Query Language
      - [x] Sintassi
      - [x] Field
      - [x] Nodi anonimi
      - [x] Wildcard
      - [x] Negazione
      - [x] Quantificatori
      - [x] Identificatori
      - [x] Raggruppamenti
      - [x] Ancoramento
      - [x] Alternative
      - [x] Predicati
- [x] Stack Graph
    - [x] Introduzione
    - [x] In Rust
    - [x] Il Domain Specific Language
      - [x] Sintassi
      - [x] Variabili
      - [x] Nodi
      - [x] Archi
      - [x] Attributi
      - [x] Shorthands
      - [x] Condizionali
      - [x] Iterazioni
      - [x] Operazioni sulle Stringhe
      - [x] Debugging
      - [x] Complementazioni
- [x] Grammatica TSG
    - [x] Language Dependency
    - [x] Algoritmo di Name Resolution di Stack Graph
    - [x] Uso di Push e Pop
    - [x] Struttura degli Archi
    - [x] Componenti Base
      - [x] Identificatori
      - [x] Classi, Interfacce, Enum e Annotazioni
      - [x] Package
      - [x] Variabili
      - [x] Metodi
      - [x] Accesso ai Campi
      - [x] Chiamata di Metodi
      - [x] Inclusione
      - [x] File
- [x] Dependency Graph
    - [x] Il Grafo
    - [x] Esempio
    - [x] Costruzione
      - [x] Analisi del Codice Sorgente
        - [x] Identificazione dei target
        - [x] Caricamento Lazy della TSG
        - [x] Parsing con Stack Graph incrementale
      - [x] Risoluzione delle Reference
        - [x] Identificazione delle reference
        - [x] Risoluzione intelligente delle reference
      - [x] Esplorazione Ricorsiva
        - [x] Identificazione del tipo di nodo
        - [x] Fully Qualified Name
        - [x] Relazioni di parentela
        - [x] Identificazione delle dipendenze
        - [x] Creazione di scope
        - [x] Passo ricorsivo
    - [x] Esportazione
      - [x] GraphML
      - [x] PUML
      - [x] Cytoscape
- [x] Testing Framework
    - [x] Approccio di Testing
    - [x] Scaffolding
      - [x] Test YAML
      - [x] Generatore di Test
    - [x] Benchmark
    - [x] Performance
- [x] Conclusione
  - [x] Dimensione dello Stack Graph
  - [x] Analisi non Differenziali
  - [x] Language Dependency
  - [x] Ulteriori Sviluppi
