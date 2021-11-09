# Systems
Systems are just regular functions
System usually take a Query if it is querying entities
System can take Commands if it is changing the World

System trait has a system() method on it that converts the function to a System.

Any thing that implements IntoSystem can be converted into System


# How Bevy Query system works.
Query<ComponentsQuery, FilterQuery>

Query will return entities and return the 

ComponentQuery can be a tuple , to return multiple components.

FilterQuery is optional, and filters all entries such they must satisfy the Filter predicate.

# WorldQuery
Trait, any type that can be queried.

Associated type, Fetch , State


&T implements WorldQuery 
    &T::Fetch is ReadFetch
    &T::State is ReadState



# Fetch trait
Item, the type that it is fetching
State, the  type that stores the state.

ReadFetch, implements Fetch

ReadFetch fetches &T components

QueryIter, implements Iterator, used to iterate through query results.
QueryIter::new
Initializes a new WorldQuery::Fetch type

Who called QueryIter::new
    QueryState::iter_unchecked_manual
        QueryState::iter_unchecked
            QueryState::iter


QueryState
    World::query() creates querystate.



How Bevy stores data.

Components
    components: Vec<ComponentInfo>
    indices , hash from typeid (compnentinfo's typeid) to usize, which is the index (into ComponentInfo?


Q: Where is component for an Entity actually stored?

# Commands
Changes a World

Example
fn add_people(command: &mut Commands) {
    command.spawn().insert(ComponentA)
}


Commands::spawn() creates EntityCommands

Entity
An entity is essentially a global unqiue id to an entity in the world.

Each Entity can have one or more components

An archetype is a collection of Components,

If 2 entities belong have the same N componenents, they both belong to the same archetype.

EntityCommands holds references to the Commands, and is allocated an Entity Id


EntityCommands insert commands into a Entity's Command queue.

ecs::system::commands::Insert 
Inserts a Component into an entity.

Insert command implements Command.
<Insert as Command>::write is the action that occurs when a Command is executed for an Insert.

Ends up calling
world.entity_mut(self.entity).insert(component)



EntityMut
Holds a mutable references to an Entity
EntityMut knows the Entity and the corresponding EntityLocation

EntityMut::insert calls insert_bundle((component,))

EntityLocation
EntityLocation is just archetype id an an index into  the archetype's table

Q: Are Components are stored organized by Archetype (????)


Data for archetype's are stored in a table
Where rows are the entities and componenets are the columns

Given a component_id and an EntityLocation.

From the archetype id, we can get the archetype stored in World.archetypes

From an Archetype instance, retrieve The Table used to store Archetype data via
World.storage.tables[archetype.table_id]

From Component Id, and a Table, retrieve the Column for that archetype. 

This will give us 1 column for all entities of a particular component.

Given an EntityLocation index , translate to a table_row
Given a table_row an Column retrieve a pointer to the component which is then safely cast to 


Column.data holds a BlocVec, that actually stores the data for the component






