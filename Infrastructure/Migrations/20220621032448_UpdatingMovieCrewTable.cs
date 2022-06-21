using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    public partial class UpdatingMovieCrewTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_Crews",
                table: "Crews");

            migrationBuilder.RenameTable(
                name: "Crews",
                newName: "Crew");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Crew",
                table: "Crew",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_MovieCrew_CrewId",
                table: "MovieCrew",
                column: "CrewId");

            migrationBuilder.AddForeignKey(
                name: "FK_MovieCrew_Crew_CrewId",
                table: "MovieCrew",
                column: "CrewId",
                principalTable: "Crew",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MovieCrew_Movie_MovieId",
                table: "MovieCrew",
                column: "MovieId",
                principalTable: "Movie",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_MovieCrew_Crew_CrewId",
                table: "MovieCrew");

            migrationBuilder.DropForeignKey(
                name: "FK_MovieCrew_Movie_MovieId",
                table: "MovieCrew");

            migrationBuilder.DropIndex(
                name: "IX_MovieCrew_CrewId",
                table: "MovieCrew");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Crew",
                table: "Crew");

            migrationBuilder.RenameTable(
                name: "Crew",
                newName: "Crews");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Crews",
                table: "Crews",
                column: "Id");
        }
    }
}
