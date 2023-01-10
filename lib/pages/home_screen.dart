import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/sign_in.dart';
import 'package:http/http.dart' as http;


class MoviesHome extends StatefulWidget {
  @override
  State<MoviesHome> createState() => _MoviesHomeState();
}

class _MoviesHomeState extends State<MoviesHome> {
  TextEditingController _searchbar=TextEditingController();
  final user= FirebaseAuth.instance.currentUser!;
  var listdata;bool isloading=true;
  var response;

  var responsetp;var responsenp;
  var listdatatp;bool isloadingtp=true;
  var listdatanp;bool isloadingnp=true;
  fetchmovies()async {
    var uriTrend=Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=e668d07eccefd678ee4ddbb79a173920");
    var uriTp=Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=e668d07eccefd678ee4ddbb79a173920&language=en-US&page=1");
    var uriNp=Uri.parse("https://api.themoviedb.org/3/movie/now_playing?api_key=e668d07eccefd678ee4ddbb79a173920&language=en-US&page=1");

    response= await http.get(uriTrend);
    responsetp= await http.get(uriTp);
    responsenp= await http.get(uriNp);
    if(response.statusCode==200){
      if(responsetp.statusCode==200){
        if(responsenp.statusCode==200)
          setState(() {
            isloading=false;isloadingtp=false;isloadingnp=false;
            listdata=jsonDecode(response.body)["results"];
            listdatatp=jsonDecode(responsetp.body)["results"];
            listdatanp=jsonDecode(responsenp.body)["results"];

          });
      }
    }

  }
  @override
  void initState() {
    fetchmovies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepPurple, Colors.pink])),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.deepPurple, Colors.pink])),
              child: Drawer(
                backgroundColor:Colors.transparent ,
                elevation: 0,
                child: ListView(

                  children: [
                    SizedBox(
                      height: 100,
                      child: Icon((Icons.person),size: 100,color: Colors.white54,),),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                          child: Center(child: Text(user.email!,style: TextStyle(color: Colors.white54),))
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: (){
                          FirebaseAuth.instance.signOut();
                        },
                        style: ButtonStyle(
                          //side: MaterialStateProperty.resolveWith((states) => BorderSide(color: Colors.white,width: 2)),
                            elevation: MaterialStateProperty.resolveWith((states) => 0),
                            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white60)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Checkbox.width*2),
                              child: Text("Log-out",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),
                    )
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.fromLTRB(50, 30, 20, 0),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _searchbar,
                    style: TextStyle(
                        fontSize: 20
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                        label: Text("What's New"),
                        //Search functionality is not added
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Color(0xffdfecea).withOpacity(0.5),
                        prefixIcon: Icon(Icons.search,color: Colors.white,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(style: BorderStyle.none,width: 0)
                        )
                    ),
                  ),
                ),
              ),
            ),
            body: ListView(
              children: [
                text("Trending Movies"),
                slides(isloading,listdata),
                text("Top Rated Movies"),
                slides(isloadingtp, listdatatp),
                text("Now Playing"),
                slides(isloadingnp, listdatanp),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget slides(bool _isloading,var _listdata){

    if(!_isloading){
      return Container(
          height: 500,
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(28, 0, 0, 0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => buildcard(index,_listdata),
            separatorBuilder:(context,index) => SizedBox(width: 20,) ,
            itemCount: listdata.length,
          )
      );

    }
    return Container(
      height: 300,
      child: Center(child: CircularProgressIndicator(),),
    );
  }

  Widget buildcard(int index,var __listdata){

    var tile=__listdata[index];
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: 300,
            child: Expanded(
              child: AspectRatio(
                aspectRatio: 3/4,
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500/"+tile["poster_path"],
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Center(
          child: SizedBox(
            width:255,
            height: 70,
            child: Text(tile["title"],style: TextStyle(

                fontSize: 20
            ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

Widget text(String txt){
  return Padding(
    padding: const EdgeInsets.fromLTRB(18, 8, 8, 8),
    child: Text(txt,style: TextStyle(fontSize: 30),),
  );
}