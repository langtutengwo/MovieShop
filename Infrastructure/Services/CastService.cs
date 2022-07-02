using ApplicationCore.Contracts.Repositories;
using ApplicationCore.Contracts.Services;
using ApplicationCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Services
{
    public class CastService : ICastService
    {
        private readonly ICastRepository _castRepository;
        public CastService(ICastRepository castRepository)
        {
            _castRepository = castRepository;
        }

        public async Task<CastDetailsModel> GetCastDetails(int id)
        {
            var castDetails = await _castRepository.GetById(id);

            var cast = new CastDetailsModel
            {
                Id = castDetails.Id,
                Name = castDetails.Name,
                ProfilePath = castDetails.ProfilePath,
                TmdbUrl = castDetails.TmdbUrl,
                Gender = castDetails.Gender,
            };


            foreach (var casts in castDetails.CastsOfMovies)
            {
                cast.Casts.Add(new CastModel { Id = casts.CastId, Name = casts.Cast.Name, Character = casts.Character });
                cast.Movies.Add(new MovieDetailsModel { Id = casts.CastId, Title = casts.Movie.Title,PosterUrl = casts.Movie.PosterUrl});
            }

            return cast;
        }
    }
}
