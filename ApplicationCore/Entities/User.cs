using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ApplicationCore.Entities
{
    [Table("User")]
    public class User
    {
        public int Id { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public string? Email { get; set; }
        public string? HashedPassword { get; set; }
        public string? Salt { get; set; }
        public string? PhoneNumber { get; set; }
        public bool? TwoFactorEnabled { get; set; }
        public DateTime? LockoutEndDate { get; set; }
        public DateTime? LastLoginDateTime { get; set; }
        public bool? Islocked { get; set; }
        public int? AccessFailedCount { get; set; }
        public ICollection<Review> ReviewsOfUser { get; set; }
        public ICollection<Favorite> FavoriteOfUser { get; set; }
        public ICollection<Purchase> PurchaseOfUser { get; set; }
        public ICollection<UserRole> UserRoleOfUser { get; set; }
    }
}
