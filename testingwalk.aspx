<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testingwalk.aspx.cs" Inherits="walkincart.testingwalk" %>

<!DOCTYPE HTML>
<html>
<head>
    <title>walkin.footwear.store</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        .story {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.9);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .story__slider {
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .story__slide {
            max-width: 90%;
            max-height: 90%;
            display: none;
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
        }

        .story__slide.active {
            display: block;
            opacity: 1;
        }

        .story__slide img, .story__slide video {
            max-width: 100%;
            max-height: 100%;
            border-radius: 10px;
        }

        .story__next, .story__prev {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            font-size: 2rem;
            color: #fff;
            cursor: pointer;
            z-index: 1001;
        }

        .story__next {
            right: 20px;
        }

        .story__prev {
            left: 20px;
        }

        .story__close {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 2rem;
            color: #fff;
            cursor: pointer;
            z-index: 1002;
        }

        .story__pagination {
            position: absolute;
            top: 10px;
            left: 0;
            right: 0;
            display: flex;
            justify-content: center;
            z-index: 1002;
        }

        .story__pagination div {
            height: 3px;
            background-color: rgba(255, 255, 255, 0.5);
            flex: 1;
            margin: 0 2px;
            position: relative;
        }

        .story__pagination div.active::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background-color: #fff;
            animation: progress 5s linear forwards;
        }

        @keyframes progress {
            0% { width: 0%; }
            100% { width: 100%; }
        }
    </style>
</head>

<body>
    <!-- WhatsApp Floating Button -->
    <a href="https://wa.me/917979717592" class="float" target="_blank">
        <i class="fa fa-whatsapp my-float"></i>
    </a>

    <!-- Story Modal -->
    <div class="story">
        <button class="story__close">&times;</button>
        <div class="story__slider swiper">
            <div class="story__wrapper swiper-wrapper">
                <!-- Slide 1 -->
                <div class="story__slide swiper-slide active">
                    <img src="https://picsum.photos/450/800" alt="Image 1">
                </div>
                <!-- Slide 2 -->
                <div class="story__slide swiper-slide">
                    <video controls autoplay muted>
                        <source src="https://exit109.com/~dnn/clips/RW20seconds_1.mp4#t=.1" type="video/mp4">
                        Your browser does not support the video tag.
                    </video>
                </div>
                <!-- Slide 3 -->
                <div class="story__slide swiper-slide">
                    <img src="https://picsum.photos/450/810" alt="Image 2">
                </div>
            </div>

            <!-- Navigation Controls -->
            <div class="story__next swiper-button-next">&#10095;</div>
            <div class="story__prev swiper-button-prev">&#10094;</div>

            <!-- Pagination (Progress Bars) -->
            <div class="story__pagination">
                <div class="active"></div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>

    <!-- Toggle Story Button -->
    <button id="toggleStoryButton">
        <img src="images/puma.jpeg" alt="Circular Image Button" style="border-radius: 50%; width: 100px; height:100px;">
    </button>

    <script>
        const toggleStoryButton = document.getElementById('toggleStoryButton');
        const storyDiv = document.querySelector('.story');
        const closeStoryButton = document.querySelector('.story__close');
        const nextButton = document.querySelector('.story__next');
        const prevButton = document.querySelector('.story__prev');
        let currentIndex = 0;
        const slides = document.querySelectorAll('.story__slide');

        toggleStoryButton.addEventListener('click', function () {
            storyDiv.style.display = 'flex'; // Use flex for centering
            startStory();
        });

        closeStoryButton.addEventListener('click', function () {
            storyDiv.style.display = 'none';
            resetStory();
        });

        nextButton.addEventListener('click', nextStory);
        prevButton.addEventListener('click', prevStory);

        function startStory() {
            showSlide(currentIndex);
            updatePagination(currentIndex);
        }

        function nextStory() {
            currentIndex = (currentIndex + 1) % slides.length;
            showSlide(currentIndex);
        }

        function prevStory() {
            currentIndex = (currentIndex - 1 + slides.length) % slides.length;
            showSlide(currentIndex);
        }

        function showSlide(index) {
            slides.forEach((slide, i) => {
                slide.classList.remove('active');
                if (i === index) {
                    slide.classList.add('active');
                }
            });
            updatePagination(index);
        }

        function updatePagination(index) {
            const progressBars = document.querySelectorAll('.story__pagination div');
            progressBars.forEach((bar, i) => {
                bar.classList.toggle('active', i === index);
            });
        }

        function resetStory() {
            currentIndex = 0;
            showSlide(currentIndex);
        }

        // Auto-advance story every 5 seconds
        setInterval(() => {
            if (storyDiv.style.display === 'flex') {
                nextStory();
            }
        }, 5000);
    </script>

</body>
</html>
