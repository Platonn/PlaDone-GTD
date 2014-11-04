# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


ProjectCategory.create([
    {name: 'Osobiste'},
    {name: 'Studia'},
                       ])

Project.create([
    {name: 'Zadanie z Ruby on Rails', project_category_id: 2},
    {name: 'Zadanie z PGK', project_category_id: 2},
               ])

Context.create([
    {name: 'Rozmowy telefoniczne'},
    {name: 'W domu'},
    {name: 'W podróży'},
    {name: 'W instytucie informatyki'},
    {name: 'Na laptopie'},
    {name: 'Na komputerze'},
    {name: 'Online'},
    {name: 'Gdziekolwiek'},
               ])

Task.create([
    {name: 'Przeczytać treść zadania z RoR.', project_id: 1, context_id: 7},
    {name: 'Zaprogramować zadanie z RoR.', project_id: 1, context_id: 5},
    {name: 'Przeczytać treść zadania z PGK.', project_id: 2, context_id: 7},
    {name: 'Zaprogramować zadanie z PGK.', project_id: 2, context_id: 5},
            ])
