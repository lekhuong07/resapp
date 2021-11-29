import 'position.dart';
/*
final List<Position> dummyPosition = <Position> [
  Position(
      id: 0,
      title: 'Main',
      section: <Section> [
        Section (
          name: 'Education',
          experience: [
            Experience (
                title: 'Bachelor of Science in Statistics & Computer Science',
                place: 'University of Illinois at Urbana Champaign',
                city_state: 'Urbana, IL',
                country: 'USA',
                start_month: 'January',
                start_year: '2017',
                end_month: 'December',
                end_year: '2019',
                description:  ['']
            ),
            Experience (
                title: 'Master of Science in Computer Science',
                place: 'California State Polytechnic University at Pomona',
                city_state: 'Pomona, CA',
                country: 'USA',
                start_month: 'August',
                start_year: '2020',
                end_month: 'May',
                end_year: '2022',
                description:  ['']
            ),
          ],
        ),
        Section (
          name: 'Skills',
          experience: <Experience>[],
          skill: [
            Skill(
                title: "Programming language",
                description: [
                  'Python', 'JavaScript', 'R', 'C++', 'Java', 'Dart'
                ]
            ),
            Skill(
                title: "Technical stacks",
                description: [
                  'Flask', 'React.js', 'Node.js', 'PostgreSQL', 'MySQL',
                  'MongoDB', 'Google Cloud', 'Airflow', 'Flutter'
                ]
            )
          ],
        ),
        Section (
          name: 'Certifications',
          experience: <Experience>[],
          skill: [
            Skill(
                title: "Data Science certificate",
                description: [
                  ' University of Illinois at Urbana Champaign (02/2019)'
                ]
            )
          ],
        ),
        Section (
            name: 'Work Experience',
            experience: [
              Experience (
                  title: 'Software Engineer Intern',
                  place: 'OpenX',
                  city_state: 'Pasadena, CA',
                  country: 'USA',
                  start_month: 'May',
                  start_year: '2021',
                  end_month: 'August',
                  end_year: '2021',
                  description: [
                    'Developed a simulation of match identity graph that mimic approximately 10% of real-world data',
                    'Created Big Query table stored providers with their corresponding entities’ data for the graph',
                    'Optimized and fixed Airflow DAGs so the whole process of building and storing graph can work properly'
                  ]
              ),
              Experience (
                  title: 'Software Engineer Intern',
                  place: 'TourMega',
                  city_state: 'San Jose, CA',
                  country: 'USA',
                  start_month: 'February',
                  start_year: '2020',
                  end_month: 'August',
                  end_year: '2020',
                  description: [
                    'Designed use cases, test specifications, and developed mobile application in React Native, JavaScript',
                    'Utilize Redux to manage application state and components to reduced 25% of redundant code',
                    'Contributed to routing algorithm which create permutations of tours for TourMega AI'
                  ]
              ),
              Experience (
                  title: 'Software Engineer Intern',
                  place: 'Rockship',
                  city_state: 'Ho Chi Minh',
                  country: 'Vietnam',
                  start_month: 'May',
                  start_year: '2019',
                  end_month: 'August',
                  end_year: '2019',
                  description: [
                    'Developed a web application to revamp existing manual working system using Python Flask',
                    'Optimized PostgreSQL database schema to achieve 10% improvement of query time',
                    'Boosted work efficiency by 50% and tested application with team of Software Developer in Test'
                  ]
              )
            ]
        ),
        Section (
          name: 'Projects',
          experience: [
            Experience (
                title: 'Club Connect App – Technical Backend Lead',
                place: 'CSS @ CPP ACM Student Chapter',
                city_state: 'Pomona, CA',
                country: 'USA',
                start_month: 'August',
                start_year: '2020',
                end_month: 'May',
                end_year: '2021',
                description: [
                  'Researched, implemented requirements engineering, setup technical specification of all products',
                  'Utilized Scrum methodology to manage different teams and boost efficiency up to 25%',
                  'Motivated team members and opened coding session to help out with algorithms and data structures',
                ]
            ),
            Experience (
                title: 'Bikes sharing analysis – Team Lead',
                place: 'Statistical Learning class project @ UIUC',
                city_state: 'Urbana, IL',
                country: 'USA',
                start_month: 'October',
                start_year: '2019',
                end_month: 'December',
                end_year: '2019',
                description: [
                  'Led and delegated tasks for group of 4 members to analyze London Bike Sharing dataset on Kaggle',
                  'Manipulated different statistical learning methods to build up models',
                  'Validated chosen models and get 70% accuracy of the chosen one'
                ]
            ),
            Experience (
                title: 'Stock price analysis – Team Lead',
                place: 'Statistical Computing class project @ UIUC',
                city_state: 'Urbana, IL',
                country: 'USA',
                start_month: 'October',
                start_year: '2018',
                end_month: 'December',
                end_year: '2018',
                description: [
                  'Led a group of 5 members in a project to evaluate and predict Google stock price in R',
                  'Cleaned datasets with thousand observations on Kaggle and created utility functions to optimize analyzation',
                  ' Applied fittest probability distribution and surpassed 50% correctness comparing to original price'
                ]
            ),
          ],
        ),
      ]
  ),
    Position(
      id: 1,
      title: 'Testing 1',
      section: <Section> [
        Section (
          name: 'Education',
          experience: [
            Experience (
              title: 'Bachelor of Science in Statistics & Computer Science',
              place: 'University of Illinois at Urbana Champaign',
              city_state: 'Urbana, IL',
              country: 'USA',
              start_month: 'January',
              start_year: '2017',
              end_month: 'December',
              end_year: '2019',
              description:  ['']
            ),
            Experience (
              title: 'Master of Science in Computer Science',
              place: 'California State Polytechnic University at Pomona',
              city_state: 'Pomona, CA',
              country: 'USA',
              start_month: 'August',
              start_year: '2020',
              end_month: 'May',
              end_year: '2022',
              description:  ['']
            ),
          ],
        ),
        Section (
          name: 'Work Experience',
          experience: [
          Experience (
            title: 'Software Engineer Intern',
            place: 'OpenX',
            city_state: 'Pasadena, CA',
            country: 'USA',
            start_month: 'May',
            start_year: '2021',
            end_month: 'August',
            end_year: '2021',
            description: [
              'Developed a simulation of match identity graph that mimic approximately 10% of real-world data',
              'Created Big Query table stored providers with their corresponding entities’ data for the graph',
              'Optimized and fixed Airflow DAGs so the whole process of building and storing graph can work properly'
            ]
          ),
          Experience (
            title: 'Software Engineer Intern',
            place: 'TourMega',
            city_state: 'San Jose, CA',
            country: 'USA',
            start_month: 'February',
            start_year: '2020',
            end_month: 'August',
            end_year: '2020',
            description: [
              'Designed use cases, test specifications, and developed mobile application in React Native, JavaScript',
              'Utilize Redux to manage application state and components to reduced 25% of redundant code',
              'Contributed to routing algorithm which create permutations of tours for TourMega AI'
            ]
          ),
          Experience (
            title: 'Software Engineer Intern',
            place: 'Rockship',
            city_state: 'Ho Chi Minh',
            country: 'Vietnam',
            start_month: 'May',
            start_year: '2019',
            end_month: 'August',
            end_year: '2019',
            description: [
              'Developed a web application to revamp existing manual working system using Python Flask',
              'Optimized PostgreSQL database schema to achieve 10% improvement of query time',
              'Boosted work efficiency by 50% and tested application with team of Software Developer in Test'
            ]
          ),
        ],
        ),
      ]
    ),
    Position(
    id: 2,
    title: 'Testing 2',
    section: [
    Section (
    name: 'Education',
    experience: [
    Experience (
    title: 'Bachelor of Science in Statistics & Computer Science',
    place: 'University of Illinois at Urbana Champaign',
    city_state: 'Urbana, IL',
    country: 'USA',
    start_month: 'January',
    start_year: '2017',
    end_month: 'December',
    end_year: '2019',
    description: ['']
    ),
    Experience (
    title: 'Master of Science in Computer Science',
    place: 'California State Polytechnic University at Pomona',
    city_state: 'Pomona, CA',
    country: 'USA',
    start_month: 'August',
    start_year: '2020',
    end_month: 'May',
    end_year: '2022',
    description: ['']
    ),
    ],
    ),
    Section (
    name: 'Projects',
    experience: [
    Experience (
    title: 'Club Connect App – Technical Backend Lead',
    place: 'CSS @ CPP ACM Student Chapter',
    city_state: 'Pomona, CA',
    country: 'USA',
    start_month: 'August',
    start_year: '2020',
    end_month: 'May',
    end_year: '2021',
    description: [
    'Researched, implemented requirements engineering, setup technical specification of all products',
    'Utilized Scrum methodology to manage different teams and boost efficiency up to 25%',
    'Motivated team members and opened coding session to help out with algorithms and data structures',
    ]
    ),
    Experience (
    title: 'Bikes sharing analysis – Team Lead',
    place: 'Statistical Learning class project @ UIUC',
    city_state: 'Urbana, IL',
    country: 'USA',
    start_month: 'October',
    start_year: '2019',
    end_month: 'December',
    end_year: '2019',
    description: [
    'Led and delegated tasks for group of 4 members to analyze London Bike Sharing dataset on Kaggle',
    'Manipulated different statistical learning methods to build up models',
    'Validated chosen models and get 70% accuracy of the chosen one'
    ]
    ),
    Experience (
    title: 'Stock price analysis – Team Lead',
    place: 'Statistical Computing class project @ UIUC',
    city_state: 'Urbana, IL',
    country: 'USA',
    start_month: 'October',
    start_year: '2018',
    end_month: 'December',
    end_year: '2018',
    description: [
    'Led a group of 5 members in a project to evaluate and predict Google stock price in R',
    'Cleaned datasets with thousand observations on Kaggle and created utility functions to optimize analyzation',
    ' Applied fittest probability distribution and surpassed 50% correctness comparing to original price'
    ]
    ),
    ],
    ),
    ]
    ),
  Position(
      id: 3,
      title: 'SWE',
      section: <Section> [
        Section (
          name: 'Education',
          experience: [
            Experience (
                title: 'Bachelor of Science in Statistics & Computer Science',
                place: 'University of Illinois at Urbana Champaign',
                city_state: 'Urbana, IL',
                country: 'USA',
                start_month: 'January',
                start_year: '2017',
                end_month: 'December',
                end_year: '2019',
                description:  ['']
            ),
            Experience (
                title: 'Master of Science in Computer Science',
                place: 'California State Polytechnic University at Pomona',
                city_state: 'Pomona, CA',
                country: 'USA',
                start_month: 'August',
                start_year: '2020',
                end_month: 'May',
                end_year: '2022',
                description:  ['']
            ),
          ],
        ),
        Section (
          name: 'Skills',
          experience: <Experience>[],
          skill: [
            Skill(
                title: "Programming language",
                description: [
                  'Python', 'JavaScript', 'R', 'C++', 'Java', 'Dart'
                ]
            ),
            Skill(
                title: "Technical stacks",
                description: [
                  'Flask', 'React.js', 'Node.js', 'PostgreSQL', 'MySQL',
                  'MongoDB', 'Google Cloud', 'Airflow', 'Flutter'
                ]
            )
          ],
        ),
        Section (
          name: 'Certifications',
          experience: <Experience>[],
          skill: [
            Skill(
                title: "Data Science certificate",
                description: [
                  ' University of Illinois at Urbana Champaign (02/2019)'
                ]
            )
          ],
        ),
        Section (
          name: 'Work Experience',
          experience: [
            Experience (
              title: 'Software Engineer Intern',
              place: 'OpenX',
              city_state: 'Pasadena, CA',
              country: 'USA',
              start_month: 'May',
              start_year: '2021',
              end_month: 'August',
              end_year: '2021',
              description: [
                'Developed a simulation of match identity graph that mimic approximately 10% of real-world data',
                'Created Big Query table stored providers with their corresponding entities’ data for the graph',
                'Optimized and fixed Airflow DAGs so the whole process of building and storing graph can work properly'
              ]
            ),
            Experience (
              title: 'Software Engineer Intern',
              place: 'TourMega',
              city_state: 'San Jose, CA',
              country: 'USA',
              start_month: 'February',
              start_year: '2020',
              end_month: 'August',
              end_year: '2020',
              description: [
                'Designed use cases, test specifications, and developed mobile application in React Native, JavaScript',
                'Utilize Redux to manage application state and components to reduced 25% of redundant code',
                'Contributed to routing algorithm which create permutations of tours for TourMega AI'
              ]
            ),
            Experience (
              title: 'Software Engineer Intern',
              place: 'Rockship',
              city_state: 'Ho Chi Minh',
              country: 'Vietnam',
              start_month: 'May',
              start_year: '2019',
              end_month: 'August',
              end_year: '2019',
              description: [
                'Developed a web application to revamp existing manual working system using Python Flask',
                'Optimized PostgreSQL database schema to achieve 10% improvement of query time',
                'Boosted work efficiency by 50% and tested application with team of Software Developer in Test'
              ]
            )
          ]
        ),
        Section (
          name: 'Projects',
          experience: [
            Experience (
                title: 'Club Connect App – Technical Backend Lead',
                place: 'CSS @ CPP ACM Student Chapter',
                city_state: 'Pomona, CA',
                country: 'USA',
                start_month: 'August',
                start_year: '2020',
                end_month: 'May',
                end_year: '2021',
                description: [
                  'Researched, implemented requirements engineering, setup technical specification of all products',
                  'Utilized Scrum methodology to manage different teams and boost efficiency up to 25%',
                  'Motivated team members and opened coding session to help out with algorithms and data structures',
                ]
            ),
            Experience (
                title: 'Bikes sharing analysis – Team Lead',
                place: 'Statistical Learning class project @ UIUC',
                city_state: 'Urbana, IL',
                country: 'USA',
                start_month: 'October',
                start_year: '2019',
                end_month: 'December',
                end_year: '2019',
                description: [
                  'Led and delegated tasks for group of 4 members to analyze London Bike Sharing dataset on Kaggle',
                  'Manipulated different statistical learning methods to build up models',
                  'Validated chosen models and get 70% accuracy of the chosen one'
                ]
            ),
            Experience (
                title: 'Stock price analysis – Team Lead',
                place: 'Statistical Computing class project @ UIUC',
                city_state: 'Urbana, IL',
                country: 'USA',
                start_month: 'October',
                start_year: '2018',
                end_month: 'December',
                end_year: '2018',
                description: [
                  'Led a group of 5 members in a project to evaluate and predict Google stock price in R',
                  'Cleaned datasets with thousand observations on Kaggle and created utility functions to optimize analyzation',
                  ' Applied fittest probability distribution and surpassed 50% correctness comparing to original price'
                ]
            ),
          ],
        ),
      ]
  ),
];
*/