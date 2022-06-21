using ApplicationCore.Entities;
using System;
namespace ApplicationCore.Contracts.Repositories
{
    public interface IMovieRepository : IRepository<Movie>
    {
        Task<IEnumerable<Movie>> Get30HighestGrossingMovies();
        Task<IEnumerable<Movie>> Get30HighestRatedMovies();
    }
}

