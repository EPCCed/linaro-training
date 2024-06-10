#include <mpi.h>
#include <iostream>
#include <vector>

void distributeIndex(std::vector<int> & local_displacements,std::vector<int> & local_sizes, int nRanks, size_t n_global)
{
    
    local_displacements.resize(nRanks);
    local_sizes.resize(nRanks);

    for(int rank=0;rank<nRanks;rank++)
    {
        auto n_local = n_global/ nRanks;
        auto remainder = n_global%nRanks;

        auto offset_local = rank * n_local;    

        if ( rank < remainder)
        {
            n_local+=1;
            offset_local+=rank;
        }
        else 
        {
            offset_local+= remainder;
        }

        local_displacements[rank]=offset_local;
        local_sizes[rank]=n_local;

    }
    

}

int main(int argc, char** argv)
{
    int rank, nRanks;

    MPI_Init(&argc,&argv);
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);
    MPI_Comm_size(MPI_COMM_WORLD,&nRanks);


    size_t n = 10000000; // size of the vector
    int nrep = 1000000; // number of iterations

    const double tol = 1e-6;

    std::vector<int> displacements;
    std::vector<int> local_sizes;


    distributeIndex(displacements,local_sizes,nRanks,n); // computes the offsets and the local number of elements for eack rank. All ranks know the distribution of the whole vector
    
    auto n_local = local_sizes[rank];
    auto offset_local = displacements[rank];

    double * a = new double [n_local ];
    double * b = new double [n_local ];
    double * c;

    for (auto i=0;i<n_local;i++)
        {
            a[i]=1;
            b[i]=i+offset_local;
        }

    for(int irep=0;irep<nrep;irep++)
    {
        if (irep % 1000 == 0 )
        {
            b = new double [ n_local ];
            for (auto i=0;i<n_local;i++)
            {
                b[i]=i+offset_local;
            }
        }
        
#pragma omp parallel for
        for (int j=0;j<n_local+1;j++)
        {
            a[j]=a[j] + b[j];
        }

    }
    
    if (rank == 0)
    {
        c = new double [n];
    //}

    // gather the result on rank 0 ( controller )
    MPI_Gatherv( a, n_local,MPI_DOUBLE,c, &local_sizes[0],&displacements[0], MPI_DOUBLE , 0 , MPI_COMM_WORLD);


    //if (rank == 0)
    //{
        // controller checks the results are correct
        for(int i=0;i<n;i++)
        {
            double expected = (i*1.*nrep + 1);
            if (std::abs(c[i] - expected  )>tol)
            {
                std::cout << "Error at " << i <<". Expected " << expected << "instead of " << c[i] << std::endl;

            }

            
        }
        std::cout << "Checked " << n << " answers" << std::endl;

    }

    

    delete[] a;
    delete[] b;
    
    if (rank ==0)
    {
        delete[] c;
    }


    MPI_Finalize();
    
}