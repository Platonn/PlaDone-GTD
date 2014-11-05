Context.create!([
  {name: "spam", color: "", icon: "", deleted_at: "2000-01-01 20:29:32"},
  {name: "rt", color: "", icon: "", deleted_at: "2000-01-01 20:39:17"},
  {name: "Rozmowy telefoniczne", color: "lightgreen", icon: "earphone", deleted_at: nil},
  {name: "W domu", color: "lightsalmon", icon: "home", deleted_at: nil},
  {name: "Gdziekolwiek", color: "lightblue", icon: "globe", deleted_at: nil},
  {name: "W podróży", color: "navajowhite", icon: "briefcase", deleted_at: nil},
  {name: "Online", color: "greenyellow", icon: "flash", deleted_at: nil},
  {name: "Na komputerze", color: "mintcream", icon: "hdd", deleted_at: nil},
  {name: "W instytucie informatyki", color: "lightpink", icon: "bell", deleted_at: nil},
  {name: "Agendy", color: "paleturquoise", icon: "user", deleted_at: nil},
  {name: "Na laptopie", color: "lightgoldenrodyellow", icon: "floppy-disk", deleted_at: nil}
])
Project.create!([
  {name: "Zadanie z Ruby on Rails", project_category_id: 2, deadline: "2014-11-09 21:59:00", deleted_at: nil, notes: nil},
  {name: "Zadanie z PGK", project_category_id: 2, deadline: "2014-11-04 11:30:00", deleted_at: nil, notes: nil}
])
ProjectCategory.create!([
  {name: "Osobiste", deleted_at: nil},
  {name: "Studia", deleted_at: nil},
  {name: "Kiedyś/Może", deleted_at: nil}
])
Task.create!([
  {name: "Przeczytać treść zadania", done: true, deadline: nil, project_id: 1, context_id: 7, time_needed: "15 min", postponed_to: nil, deleted_at: nil},
  {name: "asd", done: false, deadline: nil, project_id: nil, context_id: nil, time_needed: "", postponed_to: nil, deleted_at: "2000-01-01 01:44:39"},
  {name: "Zaprogramować zadanie", done: false, deadline: nil, project_id: 1, context_id: 5, time_needed: "", postponed_to: nil, deleted_at: "2000-01-01 01:44:52"},
  {name: "Zrobić podstawową aplikację", done: false, deadline: nil, project_id: 1, context_id: 5, time_needed: "4 h", postponed_to: nil, deleted_at: nil},
  {name: "Dostosować flow usera", done: false, deadline: nil, project_id: 1, context_id: 5, time_needed: "2 h", postponed_to: nil, deleted_at: nil},
  {name: "Zaprogramować zadanie", done: false, deadline: nil, project_id: 2, context_id: 5, time_needed: "16 h", postponed_to: nil, deleted_at: nil},
  {name: "Przeczytać treść zadania", done: false, deadline: nil, project_id: 2, context_id: 7, time_needed: "10 min", postponed_to: nil, deleted_at: nil},
  {name: "Zainstalować devise", done: false, deadline: nil, project_id: 1, context_id: 5, time_needed: "1 h", postponed_to: nil, deleted_at: nil}
])
