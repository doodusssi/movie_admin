<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/header.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        let movie_seq = '${movieInfo.mi_seq}';
    </script>
    <script src="/assets/js/movie/modify.js"></script>

    <c:if test="${mode == 'modify'}">
        <script>
            let genre_no = '${movieInfo.mi_genre_seq}';
            let viewing_age = '${movieInfo.mi_viewing_age}';
            let movie_status = '${movieInfo.mi_showing_status}';
        </script>
        <c:forEach items="${imgList}" var="item">
            <script>
                movie_imgs.push({
                    seq: '${item.mimg_seq}',
                    filename: '${item.mimg_file_name}'
                });
            </script>
        </c:forEach>
        <c:forEach items="${videoList}" var="item">
            <script>
                movie_trailer_list.push({
                    seq: '${item.tvi_seq}',
                    order: '${item.tvi_order}',
                    file: '${item.tvi_file_name}',
                    ext: '-',
                    fileSize: '-',
                    originFileName: '${item.tvi_file_name}'
                });
            </script>
        </c:forEach>
        <c:forEach items="${descList}" var="item" varStatus="stat">
            <textarea id="contentData${stat.count}" hidden>${item.content}</textarea>
            <script>
                movie_desc_list.push({
                    type: "${item.type}",
                    content: $("#contentData${stat.count}").val(),
                    order: "${item.n_order}"
                });
            </script>
        </c:forEach>
    </c:if>
    <link rel="stylesheet" href="/assets/css/movie/form.css">
</head>

<body>
    <main>
        <h1>영화 정보 <span class="type">추가</span></h1>
        <div class="basic_info">
            <h1>영화 기본 정보</h1>
            <button id="edit_basic">영화 기본정보 편집</button>
            <button id="edit_basic_save" disabled>편집내용 저장</button>
            <table>
                <tbody>
                    <tr>
                        <td>장르</td>
                        <td>
                            <select id="genre_info">
                                <c:forEach items="${genreList}" var="genre">
                                    <option value="${genre.genre_seq}">${genre.genre_name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>제목</td>
                        <td>
                            <input type="text" id="movie_name" value="${movieInfo.mi_title}">
                        </td>
                        <td>관람연령</td>
                        <td>
                            <select id="viewing_age">
                                <option value="0">전체관람가</option>
                                <option value="12">12세 이상</option>
                                <option value="15">15세 이상</option>
                                <option value="19">19세 이상</option>
                            </select>
                        </td>
                        <td>상영시간</td>
                        <td>
                            <input type="text" id="running_time" value="${movieInfo.mi_running_time}"><span>분</span>
                        </td>
                    </tr>
                    <tr>
                        <td>국가</td>
                        <td>
                            <input type="text" id="movie_country" value="${movieInfo.mi_country}"><span></span>
                        </td>
                        <td>개봉일</td>
                        <td>
                            <input type="text" id="opening_dt" 
                            value=
                            "<fmt:formatDate 
                            value=
                            "${movieInfo.mi_opening_dt}" 
                            pattern="yyyy-MM-dd" />">
                        </td>
                        <td>상영여부</td>
                        <td>
                            <select id="movie_status">
                                <option value="0">미개봉</option>
                                <option value="1">상영중</option>
                                <option value="2">스트리밍</option>
                            </select>
                        </td>
                        <td>연도</td>
                        <td>
                            <input type="text" id="movie_year" value="${movieInfo.mi_year}">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="movie_image_area">
            <h1>영화이미지</h1>
            <button id="movie_image_edit">영화 이미지 편집</button>
            <div class="movie_image_list_wrap">
                <form id="movie_img_form">
                    <input type="file" id="movie_img_select" name="file" hidden
                        accept="image/gif, image/jpeg, image/png">
                </form>
                <div class="movie_image_list">
                    <c:forEach items="${imgList}" var="img">
                        <div class="movie_img" filename="${img.mimg_file_name}">
                            <img src="/images/movie/${img.mimg_file_name}">
                            <button onclick="deleteImg('${img.mimg_file_name}' , '${img.mimg_seq}')"> &times; </button>
                        </div>
                    </c:forEach>

                </div>
                <button id="add_image" onclick="document.getElementById('movie_img_select').click()">이미지 추가</button>
            </div>
        </div>
        <div class="movie_trailer_area">
            <h1>영화 트레일러 영상</h1>
            <button id="trailer_edit">트레일러 영상 목록 편집</button>
            <div class="movie_trailer_list_wrap">
                <form id="trailer_form">
                    <input type="file" id="trailer_select" name="file" accept="video/mp4" hidden>
                </form>
                <button id="trailer_file_add" onclick="document.getElementById('trailer_select').click()">트레일러 영상
                    추가</button>
                <table id="trailer_file_table">
                    <thead>
                        <tr>
                            <td>순번</td>
                            <td>영상 파일 이름</td>
                            <td>파일유형</td>
                            <td>파일크기</td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${videoList}" var="item" varStatus="stat">
                            <tr>
                                <td>${stat.count}</td>
                                <td>${item.tvi_file_name}</td>
                                <td>-</td>
                                <td>-Bytes</td>
                                <td>
                                    <button class="delete_trailer"
                                        onclick="deleteTrailer('${item.tvi_file_name}','${item.tvi_seq}')">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
        <div class="movie_description_area">
            <h1>영화 스토리 콘텐츠 </h1>
            <button id="story_edit">스토리 콘텐츠 편집</button>
            <button id="story_save">변경내용 저장</button>
            <form id="desc_img_form">
                <input type="file" name="file" id="desc_img_select" hidden accept="image/gif, image/jpeg, image/png">
            </form>
            <button id="img_add" onclick="document.getElementById('desc_img_select').click()">이미지 추가</button>
            <button id="text_add">설명 추가</button>
            <div class="description_list">
                <c:forEach items="${descList}" var="item">
                    <c:if test="${item.type == 'img'}">
                        <div class="desc_img_box" filename="${item.content}">
                            <img src="/images/movie_desc/${item.content}">
                            <button onClick='deleteDescImg("${item.content}" , "${item.seq}")'>&times;</button>
                        </div>;
                    </c:if>
                    <c:if test="${item.type == 'text'}">
                        <div class="desc_text_box">
                            <textarea cols="30" rows="10" id="text${item.n_order}"
                                onkeyup="saveDescText('${item.n_order}')">${item.content}</textarea>
                            <button class="desc_text_del"
                                onclick="deleteDescText('${item.n_order}', '${item.seq}')">삭제</button>
                        </div>;
                    </c:if>
                </c:forEach>
            </div>
        </div>
       
    </main>
</body>

</html>