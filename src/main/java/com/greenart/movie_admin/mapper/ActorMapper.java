package com.greenart.movie_admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.greenart.movie_admin.data.actor.ActorRoleInfoVo;
import com.greenart.movie_admin.data.actor.CinemaActorInfoVO;
import com.greenart.movie_admin.data.actor.CinemaActorListVO;
import com.greenart.movie_admin.data.actor.CinemaActorPhotoVO;
import com.greenart.movie_admin.data.movie.MovieActorCastingInfoVO;
import com.greenart.movie_admin.data.movie.MovieInfoVO;

@Mapper
public interface ActorMapper {
    public Integer selectActorListPageCount(String keyword, String country);
    public List<CinemaActorListVO> selectCinemaActorList(String keyword, String country, Integer offset);
    public List<String> selectActorCountryList();
    public void insertActorInfo(CinemaActorInfoVO data);
    public void insertActrImages(List<CinemaActorPhotoVO> list); 

    public List<MovieInfoVO> selectActorRoleCntInfo(Integer offset, String keyword, String country);
    public Integer selectActorRoleCntInfoPageCount(String keyword, String country);

    public List<ActorRoleInfoVo> selectActorRoleInfo(Integer seq);
    
    public void insertActorRoleInfo(MovieActorCastingInfoVO data);
    public void deleteActorRoleInfoBySeq(Integer seq);
    public void updateActorRoleInfo(MovieActorCastingInfoVO data); 
}
