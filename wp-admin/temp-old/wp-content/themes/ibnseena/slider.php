<div class="auto-carousel">
                      
                        <div class="carousel-rail">
                            <div class="carousel-wagon">
                                                                    <?php 
$my_query = new WP_Query('cat=1&showposts=10');
while ($my_query->have_posts()) : $my_query->the_post();$do_not_duplicate = $post->ID;
?>
                                <div class="carousel-item">

                                    <article style="height:32px">
                                    <a style=" position:relative; z-index:999; color:#333;" href="<?php the_permalink() ?>"><? the_title();?></a>
                                    </article>
                                  
                                </div>
  <? endwhile ?>
                            </div>
                        </div>
                        <div style=" position:absolute; bottom:19px; left:94px;">
  
  <div class="carousel-left"></div>
  <div class="carousel-right"></div>
  </div>
                    </div>


                    
                                    <script src="<?php bloginfo('template_directory'); ?>/carousel-master/carousel.js"></script>
                <link rel="stylesheet" href="<?php bloginfo('template_directory'); ?>/carousel-master/carousel.css" />
                <script>
                    $('.carousel').carousel();
                
                    $('.auto-carousel').carousel({
                        autoplay: true
                    });
                    
                    $.easing.custom = function(m, t, b, c, d){
                        if ((t/=d) < (1/2.75)){
                            return c*(7.5625*t*t) + b;
                        } else if (t < (2/2.75)){
                            return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
                        } else if (t < (2.5/2.75)){
                            return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
                        } else {
                            return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
                        }
                    }
                    $('.custom-carousel').carousel({
                        animate : function(carousel, direction, to, isDone){
                            $this = this;
                            $this.start(carousel);
                            var speed = isDone ? 200 : 800;
                            carousel.wagon.animate({
                                'left': [to +'px', 'custom'] 
                            }, speed, function(){
                                if(isDone){
                                    carousel.wagon.animate({
                                        'left': direction == 'right' ? -carousel.way: 0 
                                    }, speed, function(){
                                        carousel.animating = false;
                                        $this.finish(carousel);
                                    });
                                } else {
                                    carousel.animating = false;
                                    $this.finish(carousel);
                                }
                            });
                        }
                    });
 
                </script>