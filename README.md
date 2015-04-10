# taskwarrior-needs-hierarchy
_Persistant filtering based on needs hierarchy (a.k.a. Mazlow Mode)_

    CAVEAT: this repository is concept, not code (so far), so if you like the idea, pitch in!
----
The needs-hierarchy extension for taskwarrior is based on a theory proposed by Abraham Maslow in his 1943 paper "A Theory of Human Motivation". see wikipedia: http://en.wikipedia.org/wiki/Maslow%27s_hierarchy_of_needs

The idea for this extension is related (complimentary) to the taskwarrior "context" functionality; a persistant filter that stays in place until you change it. It is made using mostly existing task functionality, and adds a new command [+ options]; "needs". The needs-hierarchy is a new scale that helps categorize "importance", and self-imposing focus on the most basic needs, first. It forces the user to ask him/herself the question "why do I need to do this task?", and then to assign a "Mazlow-level" [1-7].

The target-audience for this extension is taskwarrior users who want to keep track of _everything_ but then to avoid being distracted by a huge list of non-critical tasks, until the most basic needs are met.

### How it works

#### need UDA
A new UDA (User Defined Attribute) is defined, with constrained (string) values 1 - 7
The "need:" uda would be considered "required" and a value should be assigned to all tasks.

Assign a value like any other uda;

    task 142 mod need:3

#### needs command
A new command "needs" (the plural) is used to control the filtering, and to report on needs status.

    task needs 3
sets the need-hierarchy-level to "3", which is equivalent to 'need <= 3' and applies that to a persistant filter (like context) that will affect all task listings untill it is cleared or changed.
At this setting, only tasks with need:1 to need:3 will be shown in normal lists.

    task needs auto
engages an automatically set level based on the lowest (most important) level found. This is the real "magic" part, where the task-needs-hierarchy (when fully engaged) self-imposes list filtering, showing the most basic (most important) needs. If you have tasks with need:2 (Safety/ Security) then nothing but need:2 tasks will be listed. Once you complete all of the need:2 level tasks, the next level becomes visible (need:3, Friendship/ Family) and so on.

    task needs 0
is used to turn off all needs-herarchy filtering, end "Mazlow Mode".

#### Objective

#### Outcomes




