using System;
using ApplicationCore.Models;

namespace ApplicationCore.Contracts.Services
{
	public interface IMovieService
	{
	  Task<	List<MovieCardModel>> GetTopGrossingMovies();

		// get movie details
	   Task< MovieDetailsModel>	GetMovieDetails(int id);
	}
}

