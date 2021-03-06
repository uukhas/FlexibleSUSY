
#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MODULE test_root_finder

#include <boost/test/unit_test.hpp>

#include "root_finder.hpp"
#include "wrappers.hpp"

using namespace flexiblesusy;

typedef Eigen::Matrix<double,2,1> EV2_t;

BOOST_AUTO_TEST_CASE( test_parabola_2dim )
{
   auto parabola = [](const EV2_t& x) -> EV2_t {
      const double y = x(0);
      const double z = x(1);
      EV2_t f;
      f << y*(y - 5.0), z*(z - 1.0);
      return f;
   };

   Root_finder<2> root_finder(parabola, 100, 1.0e-5);
   Eigen::Matrix<double,2,1> start;
   start << 10, 10;
   const int status = root_finder.find_root(start);
   const auto root = root_finder.get_solution();

   BOOST_CHECK_EQUAL(status, GSL_SUCCESS);
   BOOST_CHECK_CLOSE_FRACTION(root(0), 5.0, 1.0e-5);
   BOOST_CHECK_CLOSE_FRACTION(root(1), 1.0, 1.0e-5);
}

static int number_of_calls = 0;

auto parabola = [](const EV2_t& x) -> EV2_t {
   number_of_calls++;
   const double y = x(0);
   const double z = x(1);
   EV2_t f;
   f << y*(y - 5.0), z*(z - 1.0);
   return f;
};

BOOST_AUTO_TEST_CASE( test_number_of_calls )
{
   const double precision = 1.0e-5;
   Root_finder<2> root_finder(parabola, 100, precision);
   Eigen::Matrix<double,2,1> start;
   start << 10, 10;
   int status = GSL_SUCCESS;

   Root_finder<2>::Solver_type solvers[] =
      { Root_finder<2>::GSLHybrid,
        Root_finder<2>::GSLHybridS,
        Root_finder<2>::GSLBroyden,
        Root_finder<2>::GSLNewton };

   for (std::size_t i = 0; i < sizeof(solvers)/sizeof(*solvers); ++i) {
      number_of_calls = 0;
      root_finder.set_solver_type(solvers[i]);
      status = root_finder.find_root(start);
      const auto root = root_finder.get_solution();

      BOOST_REQUIRE(status == GSL_SUCCESS);
      BOOST_CHECK_CLOSE_FRACTION(root(0), 5.0, precision);
      BOOST_CHECK_CLOSE_FRACTION(root(1), 1.0, precision);
      BOOST_TEST_MESSAGE("solver type " << i << " used " << number_of_calls << " calls");
   }
}
