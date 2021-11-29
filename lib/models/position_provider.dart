import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:requests/requests.dart';
import 'package:resapp/models/position.dart';

class ProviderPositions with ChangeNotifier{
  List<Position> _itemsPosition;
  ProviderPositions(this._itemsPosition);

  List<Position> get items {
    return [..._itemsPosition];
  }

  Position findById(int id){
    return _itemsPosition.firstWhere((prod) => prod.index == id);
  }

  Future<void> addPosition(String title) async {
    var response = await Requests.post(
        "https://kl-resume-app.herokuapp.com/resume/add",
        json: {
          'title': title,
        }
    );
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> deletePosition(String resumeId) async {
    var response = await Requests.delete(
      "https://kl-resume-app.herokuapp.com/resume/delete/",
        queryParameters: {
          'resume_id': resumeId,
        }
    );

    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> addSection(String resumeId, String name) async {
    var response = await Requests.post(
        "https://kl-resume-app.herokuapp.com/section/add/",
        queryParameters: {
          'resume_id': resumeId,
        },
        json: {
          'name': name,
        }
    );
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> editSection(String resumeId, String sectionId, String name) async {
    var response = await Requests.put(
        "https://kl-resume-app.herokuapp.com/section/edit/",
        queryParameters: {
          'resume_id': resumeId,
          'section_id': sectionId
        },
        json: {
          'name': name,
        }
    );
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> deleteSection(String resumeId, String sectionId) async {
    var response = await Requests.delete(
        "https://kl-resume-app.herokuapp.com/section/delete/",
        queryParameters: {
          'resume_id': resumeId,
          'section_id': sectionId
        }
    );

    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> addExperience(String resumeId, String sectionId, Map<String, String> _addData, bool isExp) async {
    String url = '';
    if (isExp){
      url = "https://kl-resume-app.herokuapp.com/experience/add/";
    }
    else{
      url = "https://kl-resume-app.herokuapp.com/skill/add/";
    }
    var response = await Requests.post(
        url,
        queryParameters: {
          'resume_id': resumeId,
          'section_id': sectionId
        },
        json: { 'data': _addData }
    );
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> editExperience(String resumeId, String sectionId, String editId, Map<String, String> _editData, bool isExp) async {
    String url = '';
    Map<String, String> query = {};
    if (isExp){
      url = "https://kl-resume-app.herokuapp.com/experience/edit/";
      query = {
        'resume_id': resumeId,
        'section_id': sectionId,
        'experience_id': editId
      };
    }
    else{
      url = "https://kl-resume-app.herokuapp.com/skill/edit/";
      query = {
        'resume_id': resumeId,
        'section_id': sectionId,
        'skill_id': editId
      };
    }
    var response = await Requests.put(
        url,
        queryParameters: query,
        json: _editData
    );
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> deleteExperience(String resumeId, String sectionId, String deletedId, bool isExp) async {
    String url = '';
    Map<String, String> query = {};
    if (isExp){
      url = "https://kl-resume-app.herokuapp.com/experience/delete/";
      query = {
        'resume_id': resumeId,
        'section_id': sectionId,
        'experience_id': deletedId
      };
    }
    else{
      url = "https://kl-resume-app.herokuapp.com/skill/delete/";
      query = {
        'resume_id': resumeId,
        'section_id': sectionId,
        'skill_id': deletedId
      };
    }
    var response = await Requests.delete(
        url,
        queryParameters: query
    );
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> fetchAndSetResume() async {
    /*final url =  "https://kl-resume-app.herokuapp.com/profile/get";
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    updateCookie(response);
    final responseData = json.decode(response.body) as Map<String, dynamic>;

    print(responseData);*/
    var response = await Requests.get(
      "https://kl-resume-app.herokuapp.com/resume/get_all",
    );
    response.raiseForStatus();
    dynamic responseData = response.json();
    if (responseData['success'] == false) {
      throw HttpException(responseData['message']);
    }
    List<Position> _addedPosition = [];

    for (int i = 0; i < responseData['data'].length; i++) {
      Map<String, dynamic> currPosition = responseData['data'][i];
      _addedPosition.add(Position(
          index: i,
          dataId: currPosition['_id'],
          title: currPosition['title'],
          section: <Section> []
      ));
      //print('-----------------currPosition---------------');
      //print(currPosition);
      for(int j = 0; j < currPosition['section'].length; j++){
        Section newSection = Section(
          index: j,
          name: currPosition['section'][j]['name'],
          dataId: currPosition['section'][j]['_id'],
          experience: <Experience> [],
          skill: <Skill> []
        );
        //print(currPosition['section'][j]['name']);
        //print(currPosition['section'][j]['experiences'].length);
        //print(j.runtimeType);
        if (currPosition['section'][j]['experiences'].length >0){
          for (int k=0; k < currPosition['section'][j]['experiences'].length; k++){
            Map<String, dynamic> currExperience = currPosition['section'][j]['experiences'][k];
            //print("----------------- currExperience --------------------");
            //print(currExperience);
            newSection.experience.add(Experience(
              index: k,
              dataId: currExperience['_id'],
              title: currExperience['exp_data']['title'],
              place: currExperience['exp_data']['place'],
              cityState: currExperience['exp_data']['city_state'],
              country: currExperience['exp_data']['country'],
              startDate: currExperience['exp_data']['start_date'],
              endDate: currExperience['exp_data']['end_date'],
              description: List<String>.from(currExperience['exp_data']['description']),

            ));
          }
        }
        else{
          for (int k=0; k < currPosition['section'][j]['skills'].length; k++){
            Map<String, dynamic> currSkill = currPosition['section'][j]['skills'][k];
            newSection.skill.add(Skill(
              index: k,
              dataId: currSkill['_id'],
              title: currSkill['exp_data']['title'],
              description: List<String>.from(currSkill['exp_data']['description']),
            ));
          }
        }
        _addedPosition[i].section.add(newSection);
        //print(newSection.length);
      }
    }
    _itemsPosition = _addedPosition;
    notifyListeners();
  }

  /*List<Position> _items = <Position> [
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
                  description:  []
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
                  description:  []
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
                  title: 'Master of Science in Computer Science',
                  place: 'California State Polytechnic University at Pomona',
                  city_state: 'Pomona, CA',
                  country: 'USA',
                  start_month: 'August',
                  start_year: '2020',
                  end_month: 'May',
                  end_year: '2022',
                  description:  ['GPA: 3.95']
              ),
              Experience (
                  title: 'Bachelor of Science in Statistics & Computer Science',
                  place: 'University of Illinois at Urbana Champaign',
                  city_state: 'Urbana, IL',
                  country: 'USA',
                  start_month: 'January',
                  start_year: '2017',
                  end_month: 'December',
                  end_year: '2019',
                  description:  ['GPA: 3.33']
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
  ];*/
}