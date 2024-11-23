import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardMovie extends StatelessWidget {

  final String id;
  final String title;
  final String image;
  final String description;

  const CardMovie({super.key, required this.title, required this.image, required this.description, required this.id});

  @override
  Widget build(BuildContext context) {
    const double valueRadioBorder = 20 ;
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: const BorderRadius.all(Radius.circular(valueRadioBorder)),
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        )]
      ),
      height: 180,
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            width: 120,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(image),
                fit: BoxFit.cover
              ),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(valueRadioBorder), topLeft: Radius.circular(valueRadioBorder)),
            )
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            title.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ),
                          ),
                          Text(
                            description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all( const Color(0xFF00838F))
                    ),
                    onPressed: (){
                      context.push('/detail/$id');
                    }, 
                    child: const Text(
                      'Ver',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}