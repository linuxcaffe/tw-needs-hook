# taskwarrior-needs-hierarchy
_Persistant filtering based on needs hierarchy (a.k.a. Mazlow Mode)_

    CAVEAT: this repository is concept, not code (so far), so if you like the idea, pitch in!
----
The needs-hierarchy extension for taskwarrior is based on a theory proposed by Abraham Maslow in his 1943 paper "A Theory of Human Motivation". see wikipedia: http://en.wikipedia.org/wiki/Maslow%27s_hierarchy_of_needs

The idea for this extension is related (complimentary) to the taskwarrior "context" functionality; a persistant filter that stays in place until you change it. It is made using mostly existing task functionality, and adds a new command [+ options]; "needs". The needs-hierarchy is a new scale that helps categorize "importance", and self-imposing focus on the most basic needs, first. It forces the user to ask him/herself the question "why do I need to do this task?", and then to assign a "Mazlow-level" [1-6].

The target-audience for this extension is taskwarrior users who want to keep track of _everything_ but then to avoid being distracted by a huge list of non-critical tasks, until the most basic needs are met.

### How it works



